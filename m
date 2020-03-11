Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from youngberry.canonical.com ([91.189.89.112]:60826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgCKPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:45:00 -0400
From: Christian Brauner <christian.brauner@ubuntu.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes v5.6-rc6
Date: Wed, 11 Mar 2020 16:44:05 +0100
Message-Id: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey Linus,

/* Summary */
This contains a single fix for a regression which was introduced when we
introduced the ability to select a specific pid at process creation time. When
this feature is requested, the error value will be set to -EPERM after exiting
the pid allocation loop. This caused EPERM to be returned when e.g. the init
process/child subreaper of the pid namespace has already died where we used to
return ENOMEM before.
The first patch here simply fixes the regression by unconditionally setting the
return value back to ENOMEM again once we've successfully allocated the
requested pid number. This should be easy to backport to v5.5.

The second patch adds a comment explaining that we must keep returning ENOMEM
since we've been doing it for a long time and have explicitly documented this
behavior for userspace. This seemed worthwhile because we now have at least two
separate example where people tried to change the return value to something
other than ENOMEM (The first version of the regression fix did that too and the
commit message links to an earlier patch that tried to do the same.).

I have a simple regression test to make sure we catch this regression in the
future but since that introduces a whole new selftest subdir and test files
I'll keep this for v5.7.

/* Testing */
All patches have seen exposure in linux-next and are based on v5.6-rc1.
I've had a build warning reported to me for the first version of the second
patch two days ago that tried to remove the unconditional initalization but
that's fixed and linux-next seemed happy. The second patch is now a pure
non-functional change.

/* Conflicts */
At the time of creating this pr no merge conflicts were reported with anything
that is expected to land this merge window.

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-03-10

for you to fetch changes up to 10dab84caf400f2f5f8b010ebb0c7c4272ec5093:

  pid: make ENOMEM return value more obvious (2020-03-09 23:40:05 +0100)

Please consider pulling these changes from the signed for-linus-2020-03-10 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-03-10

----------------------------------------------------------------
Christian Brauner (1):
      pid: make ENOMEM return value more obvious

Corey Minyard (1):
      pid: Fix error return value in some cases

 kernel/pid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

