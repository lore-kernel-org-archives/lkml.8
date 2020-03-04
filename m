Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142AC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC368215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583336869;
	bh=f2zxh8G5/PluGbSKBsmaWoGRc8nqKWvdgyQhhQS7a4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dQ0AnROETcsJTu+kwgShOMnyKw3f0dpsGi7FcqJcouTDp+M5fOt8QLgjQ09alD884
	 xa+bYPELv/FfCutc3RXM4q0gh52H8iQPplPfSraLWDkNTwt+iBGvLUktxwT45ToqdW
	 +GLETNUHmd1N5zOG6DUkghBH5ctiGsu9OCRlOB1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgCDPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgCDPrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:47:48 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF06C2166E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583336868;
        bh=f2zxh8G5/PluGbSKBsmaWoGRc8nqKWvdgyQhhQS7a4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vpiqGui5BfnLnr6xPgBCZI8TP/xts5SKofEFsTfrnMsVlJJlj7ezagg+FlVctO2+W
         twsQBtpz4iSEWV1irL6O2VEkGikGcggq8BWDL743rhYRJaedrSdRO9ED/XpEWQbs1P
         F6MsHFjKUPjODEuE+p00dR2BVlonPX2cjzri7G+M=
Received: by mail-wm1-f42.google.com with SMTP id a25so5020545wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:47:47 -0800 (PST)
X-Gm-Message-State: ANhLgQ09sC7os4Q/clbFtYFJ5Wv8FvgjCuMvuGIxBFYMu0yZCbLNTVIK
        ea3au/Y66zLtPFD73Sm7zVJDdxyejyu02yFgybu+eQ==
X-Google-Smtp-Source: ADFU+vsKLArrnWLQWlJtThuyVjaDKydGp3LxQaX8YxYSSWircwbsYCwj0DxXHJbefFDS6o2wYY4dpE66c1YI/mAZhl8=
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr4128059wmm.40.1583336866226;
 Wed, 04 Mar 2020 07:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20200303085528.27658-1-vdronov@redhat.com> <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <925307051.13073500.1583336716147.JavaMail.zimbra@redhat.com>
In-Reply-To: <925307051.13073500.1583336716147.JavaMail.zimbra@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 16:47:34 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9pDiaOUipnH_=YmWNUo+G4V_HxL6rzXML0hih4yetN8w@mail.gmail.com>
Message-ID: <CAKv+Gu9pDiaOUipnH_=YmWNUo+G4V_HxL6rzXML0hih4yetN8w@mail.gmail.com>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 16:45, Vladis Dronov <vdronov@redhat.com> wrote:
>
> Hello, Ard,
>
> > Wouldn't it be easier to pass a var_data_size stack variable into
> > efivar_entry_get(), and only update the value in 'var' if it is <=
> > 1024?
>
> I have prepared a v2 patch with an approach you suggest and will send it
> out shortly. It indeed simpler and fixes only the overflow bug mentioned.
>
> Could you, please, review it and if you like it, probably, accept it?
> In case I've implemented your idea incorrectly, could you, please,
> correct me?
>

Absolutely! Thanks for taking the time to fix these bugs, your
contributions are most welcome (and apologies if my responses
suggested otherwise)
