Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8553C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843AD2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TadlYO8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgGML1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:27:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52884 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729733AbgGML1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594639639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULXPizC4QpMXiH/m+vt5cJw3j5X+r11yFN4y9j1a/Uc=;
        b=TadlYO8e0Md+9BIzyQgwbJC/6yYzbGhM2a3PtP1JUU3ZJX60PKwoP6vuvfl0JKtzfDkfUg
        w3IazYKCXqVDGsppXT2JgjDmMYNSvV/3vxJKGXCxOZsFujW0XbdWHgsQJMOWveEblI8OK+
        ACppOU92Z67nPKLlf1yZQhEO2YGP7AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-3yevu0RaPAu9IXKn2RsD0A-1; Mon, 13 Jul 2020 07:27:15 -0400
X-MC-Unique: 3yevu0RaPAu9IXKn2RsD0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4F1D1096;
        Mon, 13 Jul 2020 11:27:13 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE70174F47;
        Mon, 13 Jul 2020 11:27:12 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [selftests] 7cb32086e5: kernel-selftests.x86.check_initial_reg_state_32.fail
References: <20200709064946.GQ3874@shao2-debian>
        <9cfe8123-9cd7-a6ec-f73b-3252d695a387@linuxfoundation.org>
        <CANoWswkjNnyBi68HL6VjX9dWt6VdjxycXV09j5L+jkCAbnrHrg@mail.gmail.com>
        <8316a170-4aee-eb57-9038-3afb91c6f0e2@linuxfoundation.org>
Date:   Mon, 13 Jul 2020 14:27:10 +0300
In-Reply-To: <8316a170-4aee-eb57-9038-3afb91c6f0e2@linuxfoundation.org> (Shuah
        Khan's message of "Fri, 10 Jul 2020 08:18:49 -0600")
Message-ID: <xunyzh831wq9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shuah!

>>>>> On Fri, 10 Jul 2020 08:18:49 -0600, Shuah Khan  wrote:

 > On 7/10/20 12:02 AM, Yauheni Kaliuta wrote:
 >> On Thu, Jul 9, 2020 at 6:36 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
 >>> 
 >>> On 7/9/20 12:49 AM, kernel test robot wrote:
 >>>> Greeting,
 >>>> 
 >>>> FYI, we noticed the following commit (built with gcc-9):
 >>>> 
 >>>> commit: 7cb32086e59b514a832a3e11f5370d37e7cfe022 ("selftests:
 >>>> simplify run_tests")
 >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
 >>>> 
 >>>> 
 >>> 
 >>> Thanks for the report. I will drop this patch for now from next.
 >>> 
 >>> Yauheni,
 >>> 
 >>> This patch broke x86 32-bit test run
 >>> make run_tests -C x86
 >>> 
 >>> Please resubmit the patch with the fix.
 >> 
 >> I did not check carefully the report, but isn't it expected that some
 >> tests are moved after the patch since they originally were placed
 >> incorrectly?
 >> 
 >> 
 > The failure doesn't have anything to do with test being moved. You can
 > reproduce this very easily by running make as shown below in x86 dir
 > under tools/testing/selftests

 > make run_tests -C x86

 > I reproduced the problem with your and patch and verified that the
 > problem tracks your patch. I dropped the patch from linux-next
 > Your other two patches in the series are fine.

 > In any case, this patch isn't really adding any functionality and
 > is a good cleanup. Let's do the cleanup right or not.


Checked.

That is because with the patch both lib.mk and x86/Makefile add
the $(OUTPUT) prefix.

So the question is to agree about the convention, should lib.mk
targets expect short test names for TEST_PROGS or full path from
the subtests' Makefiles.

The existing code is hackish (incorrectly -- adding $(OUTPUT)
only to the first list members -- tries to handle it only for
out-of-tree build).

I can make the patch without adding $(OUTPUT). It will require to
fix possible tests which provided only one test and rely on that
behaviour for the OOT build. Do you have an easy way to get a
list of such tests?


-- 
WBR,
Yauheni Kaliuta

