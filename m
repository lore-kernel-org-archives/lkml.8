Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847FE20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="t6fZeMX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgGHDmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHDmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:42:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EBFC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 20:42:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so5718401pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huCwa23AMBbOfz7D5+DWlXxIEbfsNsvNBEXQRuLMwlg=;
        b=t6fZeMX0SuGD02kfuUqZAfKh9q4fz3iVtxNq+H87jk1hEds2JAhgCUWwrZxjTnXmiz
         fmW50gkTZG5FLCo7cjsmg46AzwNJ9RW6NCpPYU5fYssxzMEpzI8LY3pjyF6pjFxM0Imp
         R8NwZnr7SUDea0/AZ/HO5D/TMJTdBkx7xuxXVZcTGGv/9PBdswjSAzv6cy0A17XduNa8
         UWkA19hZw5OJ0eCD5ezpuifSnN5rTrwwFCC6HW44PRvMoa/0jLBjrW3WwiDn51THfOU4
         kZZLlhoNWq0euVHdBHK5bCTX3nynwwKYukndYUUEsKCKvzmkF83jlDXTb+rhp3vBUpYe
         dRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huCwa23AMBbOfz7D5+DWlXxIEbfsNsvNBEXQRuLMwlg=;
        b=WKM+ZHFchuT8F8IvFEc0Co2SugNv6IPqEmXH7gHrmQLidN1aacJzul9XgZfXyqPNjh
         3xHhH+gnlvttdK6nCcX4J8sEpjm5vqFUSK8eoZSl3mYvvg55mbyiDt6m33pahbioqGL2
         Zc5KPH1Id3KOvASpKbUh7zrWjjuZny7/TJNWD/gqlz9noNdze1bHQVKWp9uKouDF+ZrM
         E9KdIqoVaLbTa/sbRJZcs4JB5nLI5UZW6XhEuqvHadx3CCSppiFz2tfnuFEGk981SXDI
         rNQqE09qn3WgQwB4XJFi5orJHklmYLybn6T510DjQwK7CARJgHGNNNSNz7albF4VQMXk
         HgCw==
X-Gm-Message-State: AOAM530kN756EAvltOCTnHjWD1qnBvyKkyMl2a/eTlviHAzd1P9A6+I/
        S1k9kuXXD6ScHW1RS7Rk7OA2/g==
X-Google-Smtp-Source: ABdhPJymDdsaLbNFhW83EpDlAYtnJyl4/MgTzUzkHhkKSUVvG0xV5Z5g86EB4pW841dZ2DMEqlZFmQ==
X-Received: by 2002:a63:d10a:: with SMTP id k10mr48115685pgg.382.1594179772295;
        Tue, 07 Jul 2020 20:42:52 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id t184sm24228651pfd.49.2020.07.07.20.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 20:42:51 -0700 (PDT)
Date:   Tue, 7 Jul 2020 20:42:41 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200707204241.36bea66a@hermes.lan>
In-Reply-To: <4592008a-16ee-d8c4-4ec3-5e36a268e5d6@gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <1cceba0f-c8ad-260d-9a09-5417bee32d50@gmail.com>
        <20200706181052.174c290a@oasis.local.home>
        <717030b7-ecba-2ca4-39ff-6a5a04a732d4@gmail.com>
        <20200706182819.3467fa32@oasis.local.home>
        <4592008a-16ee-d8c4-4ec3-5e36a268e5d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 02:03:36 +0300
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 07/07/2020 01:28, Steven Rostedt wrote:
> > On Tue, 7 Jul 2020 01:17:47 +0300
> > Pavel Begunkov <asml.silence@gmail.com> wrote:
> >   
> >> Totally agree with you! But do we care then whether two _devices_ or _objects_
> >> are slave-master? Can't see how it fundamentally differs.  
> > 
> > The term slave carries a lot more meaning than subordinate. I replied to
> > someone else but later realized that the person sent me their reply
> > offlist, so my reply to them was also offlist. What I told them was,
> > back in college (decades ago), when I first mentioned "master/slave" in
> > conversation (I think it was about hard drives), a person in that
> > conversation stated that those were not very nice terms to use. I blew
> > it off back then, but after listening to more people, I found that
> > using "slave" even to describe a device is not something that people
> > care to hear about.  
> 
> That's cultural, but honestly I've never seen such a person. I still
> don't understand, why having secondary or subordinate object belittling
> the owned side by not providing it the same rights and freedom is OK,
> but slave/master objects are not. Where is the line?
> 
> 
> > 
> > And in actuality, does one device actually enslave another device? I
> > think that terminology is misleading to begin with.  
> 
> As mentioned, I do like good clear terminology, and if it conveys the idea
> better, etc., then it's worth to try. And IMHO that's the right reasoning
> that should be behind. Otherwise, for almost every word we can find a person
> seeing something subjectively offensive or at least bad in it.

Wherever possible the kernel should use the same terminology as the current
standard in that area. Many of the master/slave references in the networking
code are for protocols based on IEEE 802 standards (unfortunately paywalled).
The current version of those standards do not use this kind of wording and the
standards committees are also actively working on inclusive language statemets.

As far as the use of master/slave for bonding, bridge, team etc, it
looks like Linux just invented using those terms since I don't see it
any other vendors implementations Cisco/Juniper/Arista/... Linux terms
are different than industry norms in networking, this is not a good
thing. But changing human expectations is hard.


