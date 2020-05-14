Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8552FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6952B2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgENRF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:05:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49252 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgENRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:05:26 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZHIT-0006It-02; Thu, 14 May 2020 17:05:25 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes v5.7-rc5
Date:   Thu, 14 May 2020 19:04:51 +0200
Message-Id: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a single fix for all exported legacy fork helpers to block
accidental access to clone3() features in the upper 32 bits of their
respective flags arguments.

I got Cced on a glibc issue where someone reported consistent failures for
the legacy clone() syscall on ppc64le when sign extension was performed
(Since the clone() syscall in glibc exposes the flags argument as an int
 whereas the kernel uses unsigned long.).

The legacy clone() syscall is odd in a bunch of ways and here two things
interact. First, legacy clone's flag argument is word-size dependent, i.e.
it's an unsigned long whereas most system calls with flag arguments use int
or unsigned int. Second, legacy clone() ignores unknown and deprecated
flags. The two of them taken together means that users on 64bit systems can
pass garbage for the upper 32bit of the clone() syscall since forever and
things would just work fine. The following program compiled on a 64bit
kernel prior to v5.7-rc1 will succeed and will fail post v5.7-rc1 with
EBADF:

int main(int argc, char *argv[])
{
        pid_t pid;

        /* Note that legacy clone() has different argument ordering on
         * different architectures so this won't work everywhere.
         *
         * Only set the upper 32 bits.
         */
        pid = syscall(__NR_clone, 0xffffffff00000000 | SIGCHLD,
                      NULL, NULL, NULL, NULL);
        if (pid < 0)
                exit(EXIT_FAILURE);
        if (pid == 0)
                exit(EXIT_SUCCESS);
        if (wait(NULL) != pid)
                exit(EXIT_FAILURE);

        exit(EXIT_SUCCESS);
}

Since legacy clone() couldn't be extended this was not a problem so far and
nobody really noticed or cared since nothing in the kernel ever bothered to
look at the upper 32 bits.

But once we introduced clone3() and expanded the flag argument in struct
clone_args to 64 bit we opened this can of worms. With the first flag-based
extension to clone3() making use of the upper 32 bits of the flag argument
we've effectively made it possible for the legacy clone() syscall to reach
clone3() only flags on accident. The sign extension scenario is just the odd
corner-case that we needed to figure this out.

The reason we just realized this now and not already when we introduced
CLONE_CLEAR_SIGHAND was that CLONE_INTO_CGROUP assumes that a valid cgroup
file descriptor has been given whereas CLONE_CLEAR_SIGHAND doesn't need to
verify anything. It just silently resets the signal handlers to SIG_DFL. So
the sign extension (or the user accidently passing garbage for the upper 32
bits) caused the CLONE_INTO_CGROUP bit to be raised and the kernel to error
out when it didn't find a valid cgroup file descriptor.

/* A final note */
Note, I'm also capping kernel_thread()'s flag argument mainly because none
of the new features make sense for kernel_thread() and we shouldn't risk
them being accidently activated however unlikely. If we wanted to, we could
even make kernel_thread() yell when an unknown flag has been set which it
doesn't do right now. But it's not worth risking this in a bugfix imho.

/* Testing */
All patches have seen exposure in linux-next and are based on v5.6-rc5.

/* Conflicts */
At the time of creating this pr no merge conflicts were reported.

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-05-13

for you to fetch changes up to 3f2c788a13143620c5471ac96ac4f033fc9ac3f3:

  fork: prevent accidental access to clone3 features (2020-05-08 17:31:50 +0200)

Please consider pulling these changes from the signed for-linus-2020-05-13 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-05-13

----------------------------------------------------------------
Christian Brauner (1):
      fork: prevent accidental access to clone3 features

 kernel/fork.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
