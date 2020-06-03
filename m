Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B14D20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591143376;
	bh=NaQrqvbJtsvnfeHmNpXGsKPAF5utzImNGStlY5KnIt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nknwY1E85sxspCp0gX/UXDxb5nMBwOexwrDxzCwWIJp/ykBgUMV0cu7ZIOvdK1WNe
	 /6keVWfJW0Hv7cUXZ+7N1aUb5jovVB8A1BTzWB7ADTDKqY60H3Xm9jvj78/zPSBk89
	 rI8xRtQWmE/b+sPYeCikB/9VgfROMbrTPtBVfwNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFCAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:16:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE94C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:16:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so445129lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8hJYQ+rT235Ea6JWRxsMjDChbaKBs3WgPV6XuNeVEM=;
        b=AqPBITwj3FjR7rqIyNNFayXEwz1gK6Yyxnoa/T4EKJ6pNVfWvXrETDdXLt5zGbypPK
         Uz5MZjGmT81Mr2dIdb/mJYnX6zyDZyBsOEhOF7n8VpU8U5lBryFrpixulJ/sw0Cnyoqx
         74HvIbDUSSYZE2PXXHNiTP3+ZHPNGyk9AGJ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8hJYQ+rT235Ea6JWRxsMjDChbaKBs3WgPV6XuNeVEM=;
        b=Z5epzN1wz5V+GuY41sSXCGEkHI8e+P6JvHMP0VYfxpGH8F7xdbQ1nZ4mgPXEuPIfwd
         NJOqxDvAAwOnVplY/laiU/CiX1lMc8DWgzvHGLfhcwAzPh32pjF0IGMn1H1xtx8WbzvQ
         lNBGrw8gZqdttusRNRHpk8073oTp1Qz1nTdlQM/wgJdosturTIzg9iEygM9JhimQDLj2
         Kl6OEw0bUgs77G1VpgynDJSY0Cj7JYwf/K1vyEBGbkvGSspAzVLY3Ve6rd+In0miB/ps
         rpbuKlSCGhUq4jlKhfRjQE4UKSn0QdUrEF0LeRU/z+cFKtbozkc6biI/GT7+tD4rN4l2
         OA6A==
X-Gm-Message-State: AOAM530cBuERao0mBIUWFSBtsKYEWy/iCefy1aIhwoG+4tcDTBlXcRHy
        BIkzWKXw4DXAzpZKtNw7OHKhmFItcWY=
X-Google-Smtp-Source: ABdhPJxeDcnONiYriAQ80KIUMsWBSmLfFXMoeqowSdZ1RD9b29Imj+vgUKkr+t3jjhZXIMO1d51IRg==
X-Received: by 2002:a2e:90d1:: with SMTP id o17mr724671ljg.206.1591143372771;
        Tue, 02 Jun 2020 17:16:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 66sm170802lfk.54.2020.06.02.17.16.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:16:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z9so428242ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:16:11 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr681936ljn.70.1591143371526;
 Tue, 02 Jun 2020 17:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
In-Reply-To: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzabBsjeGyjE9jHDiLT+CbCYhkLq8xUyWemue2zohrew@mail.gmail.com>
Message-ID: <CAHk-=wgzabBsjeGyjE9jHDiLT+CbCYhkLq8xUyWemue2zohrew@mail.gmail.com>
Subject: Re: [GIT PULL] Audit patches for v5.8
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 5:49 PM Paul Moore <paul@paul-moore.com> wrote:
>
>       Unfortunately I just noticed
> that one of the commit subject lines is truncated - sorry about that,
> it's my fault not Richard's - but since the important part is there
> ("add subj creds to NETFILTER_CFG") I opted to leave it as-is and not
> disrupt the git log.  If you would rather have the subject line fixed,
> let me know and I'll correct it.

It looks a bit odd, but not worth the churn of fixing up. Thanks, pulled,

                  Linus
