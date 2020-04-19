Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A43C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E05E2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmeerw.org header.i=@cmeerw.org header.b="csymuxS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDSUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:20:03 -0400
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Apr 2020 13:20:03 PDT
Received: from edge.cmeerw.net (edge.cmeerw.net [IPv6:2a0a:51c0::ffa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C07C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmeerw.org;
         s=dkim; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vosaZNW/nzOhYp8ly6wwnaMNuL098/ux4UA6Rec2m0A=; b=csymuxS/yrCjGcUllzsuowYTXb
        xQ94xqA2yhRXypbuV/QOAHNkQB/SYoD4Rq3o/2DoRWbPBzFz1Slc+hW4Ff6CKNWW2QzieKtCML4l8
        GTOmKKNREvuLKUt1rE2F4XxBCqavmkcoEybR55fDjrPy4W5gNEwQf0KStYaCuhrQS9oM=;
Received: from cmeerw by edge.cmeerw.net with local (Exim 4.93)
        (envelope-from <cmeerw@cmeerw.org>)
        id 1jQGJs-0004SY-5G; Sun, 19 Apr 2020 22:13:36 +0200
Date:   Sun, 19 Apr 2020 22:13:36 +0200
From:   Christof Meerwald <cmeerw@cmeerw.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>
Subject: SIGCHLD signal sometimes sent with si_pid==0 (Linux 5.6.5)
Message-ID: <20200419201336.GI22017@edge.cmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: 1024D/2B10BE68, 1998-06-29
X-PGP-Fingerprint: 0289 5466 C1F5 B03C DBA7  6304 8CAF 9782 2B10 BE68
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is probably related to commit
7a0cf094944e2540758b7f957eb6846d5126f535 (signal: Correct namespace
fixups of si_pid and si_uid).

With a 5.6.5 kernel I am seeing SIGCHLD signals that don't include a
properly set si_pid field - this seems to happen for multi-threaded
child processes.

A simple test program (based on the sample from the signalfd man page):

#include <sys/signalfd.h>
#include <signal.h>
#include <unistd.h>
#include <spawn.h>
#include <stdlib.h>
#include <stdio.h>

#define handle_error(msg) \
    do { perror(msg); exit(EXIT_FAILURE); } while (0)

int main(int argc, char *argv[])
{
  sigset_t mask;
  int sfd;
  struct signalfd_siginfo fdsi;
  ssize_t s;

  sigemptyset(&mask);
  sigaddset(&mask, SIGCHLD);

  if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
    handle_error("sigprocmask");

  pid_t chldpid;
  char *chldargv[] = { "./sfdclient", NULL };
  posix_spawn(&chldpid, "./sfdclient", NULL, NULL, chldargv, NULL);

  sfd = signalfd(-1, &mask, 0);
  if (sfd == -1)
    handle_error("signalfd");

  for (;;) {
    s = read(sfd, &fdsi, sizeof(struct signalfd_siginfo));
    if (s != sizeof(struct signalfd_siginfo))
      handle_error("read");

    if (fdsi.ssi_signo == SIGCHLD) {
      printf("Got SIGCHLD %d %d %d %d\n",
          fdsi.ssi_status, fdsi.ssi_code,
          fdsi.ssi_uid, fdsi.ssi_pid);
      return 0;
    } else {
      printf("Read unexpected signal\n");
    }
  }
}


and a multi-threaded client to test with:

#include <unistd.h>
#include <pthread.h>

void *f(void *arg)
{
  sleep(100);
}

int main()
{
  pthread_t t[8];

  for (int i = 0; i != 8; ++i)
  {
    pthread_create(&t[i], NULL, f, NULL);
  }
}


I tried to do a bit of debugging and what seems to be happening is
that

		/* From an ancestor pid namespace? */
		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {

fails inside task_pid_nr_ns because the check for "pid_alive" fails.

This code seems to be called from do_notify_parent and there we
actually have "tsk != current" (I am assuming both are threads of the
current process?)


Christof

-- 

http://cmeerw.org                              sip:cmeerw at cmeerw.org
mailto:cmeerw at cmeerw.org                   xmpp:cmeerw at cmeerw.org
