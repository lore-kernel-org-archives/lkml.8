Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD1C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34BA222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5K7at91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBGESf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:18:35 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:40688 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:18:34 -0500
Received: by mail-qk1-f178.google.com with SMTP id b7so975561qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 20:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t2sBZ0a3hg/kZLgY72Jvj9ZeaX47eWmd4cLLHPJYuYk=;
        b=G5K7at91AM+KHiaSybioSqlKfEYlR42w8HRMtsMJ8jjrwz0mb/qx7NnNXVnHm2dYoZ
         /KnemLlqW0Oo7MjRWfRrj5eNHbpHJifs0sc810MD2ZKtjnbtAPGIFTyj6n7LKgWQlPds
         JBBfBSxhKP1NDlRjSBCzkvoaYd+ZeSF1AsZisKuwIor5XbSZJQWtg44GQEV+7e8NqNDu
         L7t0QZ87pxCYk2iI/DB65I3wcyHamXJ4j1FhHsu48x5ZUbbsEiV1EOr7htZvpZ4pOFt/
         jyur7srtf+rNE0tlJEwC4ZhD8KWuWzkcfLXf8dlHiO++5R1U5EdxswA7gmr31KBMTl93
         //yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t2sBZ0a3hg/kZLgY72Jvj9ZeaX47eWmd4cLLHPJYuYk=;
        b=He5hyAegGyQ1bzczV/u9BCr+MUbuM2SoUCAVrYykJW2Z76Xkv5jC5SudWfhbPp7chZ
         7oO+36jleUVSoK6yK6dVSaSIlcJZtDt+wke81PKNNE72Id6+xNs89T9RvOoKLrAsMeUt
         69kdlFM71QtGd0BpmLKVvlyWq1+d40rrNyD6ciGxXkAMVRAkQFIZMVm3T2pA7A/CGvvJ
         lZgjpfqoRug2SIblZ4kMpA67NymjLlSrZW/3qbOSpxB0+E7fvwpmb9aZG0VATay/yMHc
         rnlW2fziIARbyLclLuj1JKu7pKtP7u3HM4JizohToOagIZxWphyNWZPj4frphpcBhmmo
         4FQw==
X-Gm-Message-State: APjAAAVaackVlmw6lV0/BLO2hvLno8WjQIBhB4+/CKzcXPNNWUGu6tF3
        pHIgKx17nqWKDVlzf9po4AQ=
X-Google-Smtp-Source: APXvYqwUnWAcZ06AsUt/rfeMlelaYyBl1831AEKn8scqMOEYCYofXIR4wfEpVD1nrtuu+fQEiNgrnA==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr5543629qkf.480.1581049113496;
        Thu, 06 Feb 2020 20:18:33 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w60sm778921qte.39.2020.02.06.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 20:18:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 23:18:31 -0500
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
Message-ID: <20200207041831.GA3091628@rani.riverdale.lan>
References: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
 <20200206231211.GA2976063@rani.riverdale.lan>
 <20200206233325.GA3036478@rani.riverdale.lan>
 <cda542ae-e0ea-a9bc-53bc-8e91e06d254d@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cda542ae-e0ea-a9bc-53bc-8e91e06d254d@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:29:42PM -0600, Larry Finger wrote:
> On 2/6/20 5:33 PM, Arvind Sankar wrote:
> > On Thu, Feb 06, 2020 at 06:12:13PM -0500, Arvind Sankar wrote:
> >> On Thu, Feb 06, 2020 at 04:46:52PM -0600, Larry Finger wrote:
> >>> When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the
> >>> following error:
> >>
> >> It's not that the attributes are wrong. The problem is that BUILD_BUG_ON
> >> requires a compile-time evaluatable condition. gcc-4.6 is apparently not
> >> good enough at optimizing to reduce that expression to a constant,
> >> though it was able to do it with the array accesses.
> > 
> > Should have noted, it fails on x86 too with gcc-4.6.4, not specific to PPC.
> 
> What pre-processor test would be correct to skip the test for gcc4?
> 
> Larry
> 

I think the patch you bisected to is broken. It should not use
BUILD_BUG_ON with a condition that is not obviously compile-time
evaluatable.
