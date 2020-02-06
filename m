Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE495C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX4Q6GLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBFXd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:33:29 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:41040 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:33:29 -0500
Received: by mail-qt1-f173.google.com with SMTP id l19so508525qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 15:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWF+YrSBN9I9az3pFmDlZfo93OT6sbltTxv4F3WOilM=;
        b=IX4Q6GLQTo0lj1iVjZ6GCCrrGVLrn+LaerRaE05PmD2e5PuoKFZUV2KK6re0uG4gOB
         k0R1Vd0stswCu/w8P2Ybhs+iQc5cw2U3lV2EEQppiIAC+5dumCt2iqrdebwM7gra+a0U
         nfzSUiamKGVMc36s5afotmWWxc87jhX/12kfd5MpIgec2fZSii5gShCf+FlrlLn4Rep0
         xBcoyKy+jL1S7lAqD3M882W9y0KCNPNihd36dH4RkFnDiWro/X6g6uVygbJa3kRfXZFr
         2g4B2lJeWuuuNTG3rMLKfp1qzh5Q4w9vnepZz1SiodhfVWv/h8g3uFtmFuEj84QR4h/J
         i+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWF+YrSBN9I9az3pFmDlZfo93OT6sbltTxv4F3WOilM=;
        b=Tj9/To/ra0nDAYU9e/Kf/mTBeiBsfatY/BxanSA/irJd+BA6McbedsRG8f5u2DLe4/
         NsSrDDbqGpRuzX/dWq2QE8GGfX2dbNrdyVCuo7hccoGkELLB3T3Ovr0kTXFwOBJgIzM7
         ZIVvNIUr2s15RMwRBHBpX2mhwRBnrTix1+455c3O07z8d9CjLfUzpvNa2FYUyUJNMBvO
         5REaBaAJaTzrNQtaQx96tiZIGuNAe7bTak9iOBJrcrdLdO2JLPgLsPhcF9NUYpxyczQL
         K7ZjADDDIeFzvksnSW5U2C/3kwOdvICYZKaRWvTbZcJDupzPKZQQ2jpMet7bbD+0RXnV
         otzQ==
X-Gm-Message-State: APjAAAUcv9ub4jcNZLF3oi66biOhiPwUCjNGwdW06Q23MJWxkBMai0W+
        VIFUqgNIlkBkmHH+CH22iEU=
X-Google-Smtp-Source: APXvYqybggS50imjjg9zCEdM35rSxGUT5eqPKSCNFnNy/9NRBWBgkHXug+Rp0Wq7rYLbE77U/Ig6+w==
X-Received: by 2002:ac8:6f75:: with SMTP id u21mr5052047qtv.52.1581032008284;
        Thu, 06 Feb 2020 15:33:28 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w21sm516752qth.17.2020.02.06.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 15:33:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 18:33:26 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
Message-ID: <20200206233325.GA3036478@rani.riverdale.lan>
References: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
 <20200206231211.GA2976063@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206231211.GA2976063@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:12:13PM -0500, Arvind Sankar wrote:
> On Thu, Feb 06, 2020 at 04:46:52PM -0600, Larry Finger wrote:
> > When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the 
> > following error:
> 
> It's not that the attributes are wrong. The problem is that BUILD_BUG_ON
> requires a compile-time evaluatable condition. gcc-4.6 is apparently not
> good enough at optimizing to reduce that expression to a constant,
> though it was able to do it with the array accesses.

Should have noted, it fails on x86 too with gcc-4.6.4, not specific to PPC.
