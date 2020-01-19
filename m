Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889DEC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619322468C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgASCRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 21:17:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:2714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgASCRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 21:17:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 18:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="219304997"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2020 18:17:04 -0800
Date:   Sun, 19 Jan 2020 10:17:15 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200119021715.GB9745@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard>
 <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
 <20200117234829.GA2844@richard>
 <cc48623f-329b-ec43-a85a-d9a914ca87bc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc48623f-329b-ec43-a85a-d9a914ca87bc@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 05:38:10PM -0800, Mike Kravetz wrote:
>On 1/17/20 3:48 PM, Wei Yang wrote:
>> This is another point I think current code is not working well. And actually,
>> the behavior is not well defined or our kernel is broken for a while.
>> 
>> When you look at the man page, it says:
>> 
>>     RETURN VALUE
>>            On success move_pages() returns zero.  On error, it returns -1, and sets errno to indicate the error
>> 
>
>Is this from your migrate_pages(2) man page?
>

It is from my move_pages(2) man page.

>The latest version of the migrate_pages(2) man page in the git repo has this
>for RETURN VALUE.
>
>RETURN VALUE
>       On  success  migrate_pages() returns the number of pages that could not
>       be moved (i.e., a return of zero means that all pages were successfully
>       moved).  On error, it returns -1, and sets errno to indicate the error.
>
>-- 
>Mike Kravetz

-- 
Wei Yang
Help you, Help me
