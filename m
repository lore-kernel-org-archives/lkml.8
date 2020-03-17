Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CEC20757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4KKZLjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCQNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:46:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44504 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgCQNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:46:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so11964861pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5J45eIeJgWFUl2h4NYbnycSip/ojAAmeGMGD4sGnuw=;
        b=M4KKZLjNUID+vGh4gsHEtXBSH4/kqG1zW9Kw9JkuO79PzYyT8HDpKrRJMomhdKI7/6
         EGCoUpeGOeVFqbsdVgzutdxQlmiPz9Jgf2SOSS1p1F2Hj4+DMZkivKLMX9DRoTI/1WBc
         PYhqOrbYR0rlhJm4ELaNMHJzf6z3TTyqIfsPcrQESW0caRrUTffWdQdfKlvPKDYR4H5N
         l60V9KexBCszCHDss355vlLSUv6QhEd/S1GtfRkYoK9489direOYhJ8TYOImZg3Dqc0Q
         A7H26uwFJZr1YFKAY0UGa7sVXcyJcJ4LsOxvXb5TA2GwYhEfoAdHtodXm2pUBJUD+vIk
         kW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5J45eIeJgWFUl2h4NYbnycSip/ojAAmeGMGD4sGnuw=;
        b=O/ndKL3tAZ4xWFdI89xe4XuF6glouzi9Ks712xr5P4NeSd2XwfXjGVz6NcWrCfMGBn
         U/6UapnO/5GgAsgldLqTCD8TAImfvAshYQxm5pnroNIn3jTVoNhGoNm9MBJD9YUKZDSb
         8eNWKC/XMOJ18KSdUew/1RrVxCP1qNlkCDO9710HVJ+1apnKW+dv5ssYk/s9CbpHyTSd
         E2oKtTX2AiT4UL7oIw3jnM696YwUtsNs+EmTr8Ure8b4wbIH9FgD4ZLrzRokLf3TJpMZ
         zv+OPkIdfLWi4LUNU0/qGj3tLb96XqwEIEZSxAFLdSnk2B8f4CN9b94MUOOZVZu+FCBj
         MAtw==
X-Gm-Message-State: ANhLgQ2Qtmzwt/S0V00txYdKVKc00eBt2uBCJITSrahOvOsI4d4S4xVo
        od/4AqmFh1lAaglvx1l6K7RBRFpGCB3Sv0CCvdhzBQ==
X-Google-Smtp-Source: ADFU+vva8QSwFdcsMhSZjWQYHZKfwHAWNBDeutvy8/kYq4kZfBMbrTAsOL+QcUH9wTViNLO4LEYU1KBWFkjzUXRsNbg=
X-Received: by 2002:a63:2323:: with SMTP id j35mr5200321pgj.440.1584452767887;
 Tue, 17 Mar 2020 06:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200317185748.085ecf7f@canb.auug.org.au>
In-Reply-To: <20200317185748.085ecf7f@canb.auug.org.au>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Mar 2020 14:45:56 +0100
Message-ID: <CAAeHK+zvcvxxxGKEhBm3t8rWoyMMEoGYJPpaW3-3sk4__PYJJg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the usb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 8:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the usb tree, today's (actually yesterday's) linux-next
> build (powerpc allyesconfig) produced these warnings:
>
> ./usr/include/linux/usb/raw_gadget.h:74:12: warning: 'usb_raw_io_flags_zero' defined but not used [-Wunused-function]
>    74 | static int usb_raw_io_flags_zero(__u16 flags)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> ./usr/include/linux/usb/raw_gadget.h:69:12: warning: 'usb_raw_io_flags_valid' defined but not used [-Wunused-function]
>    69 | static int usb_raw_io_flags_valid(__u16 flags)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   f2c2e717642c ("usb: gadget: add raw-gadget interface")
>
> Missing "inline" n a header file?

Hi Stephen,

Yes, same issue as reported here:
https://github.com/ClangBuiltLinux/linux/issues/934

Thanks for the report!

Greg, should I send a new version with the fix right now, or is it OK
to wait until we get comments from Felipe/Alan and then send a new
version?
