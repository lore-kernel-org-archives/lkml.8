Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 05:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEF9221EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 05:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LopPYPEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGNFsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 01:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 01:48:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5337C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 22:48:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so3091467wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EAzKSdWricR5ttWzxJcej8NnEUGQf3yoT+bgnVWs/aY=;
        b=LopPYPEv0sMvHpbJPRIQq+MnF2YNyNYbxkfS3l3gFCUkzQ6ckXkW6gyRWP2XQHfLP8
         4p8bft2/UBgELkFsi+7VAl//mZGGFuaD74PdHAV3rUpwTWiWj4QhVD6H3KUXLKkxCU5H
         Hb81jh/UiO1Pm83Atys1VviCzytmmDj2ZFdF/L5A3lQ8QRXoiWnE9gB+wBKwB28CODJk
         XpXv7ND4SPkKNMTNafdcniArk1gJFeDNmGPuAGqtbeWzGJBvmbG6gdC+kZqfa6JFZAm9
         /44SyLzdjD/wd/KJ6ZMjUFtK+8ayIXe+kS6WcmmjrCCy9Y5I6mF9ivZaXIOujrsb2lFK
         BMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EAzKSdWricR5ttWzxJcej8NnEUGQf3yoT+bgnVWs/aY=;
        b=fyXNdIgm/SAbUEmaYDzwwxWDSAyWuKD1jiA33xC0HSakOgxujso6lUFBhoFWn7CWUR
         F6f3L5WCCCb2wehU3+lw++nNbZ+K14EnbXwyPtJT3/ahwAnrenV2t1RKtn1cLvApk1h2
         ofJXGb4+2HcXW+nuAf2I9ptg/VRIrEb89nG2UIuJmY86V0G9yfm7QhpayALVc61nrfk+
         mICb66T4l1I43V1ncACw95QnZjhdh/ZujfXH2qddEgdRUxA8Fhk0liZi9czPxKtVVO1j
         WoIE/mn5rRvUmpnv0SUo9u2dBZOEF2Kpl+4wVKb2GZgDQwsA2OYrCmtJKPepdWMDKEOB
         cogA==
X-Gm-Message-State: AOAM532N91OS1ARCzx5nuQu8NM/9URHhoZ72uTpYc+4hcaY7Cr7UntxN
        90ZnBWiaZDMoUA+t0wKgunQ=
X-Google-Smtp-Source: ABdhPJyc/LwHvI/XIqOZYVldXieGlMH8I8uy8BpZn77lXHp6Qlr59Ka9C1mLlgijviGlXqc5OhzaEg==
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr2564530wmd.36.1594705686282;
        Mon, 13 Jul 2020 22:48:06 -0700 (PDT)
Received: from felia ([2001:16b8:2d88:ea00:c4fb:750d:a5d0:9d75])
        by smtp.gmail.com with ESMTPSA id j4sm27982046wrp.51.2020.07.13.22.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 22:48:05 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 14 Jul 2020 07:47:58 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Mrinal Pandey <mrinalmni@gmail.com>
cc:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
In-Reply-To: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
Message-ID: <alpine.DEB.2.21.2007140742570.6558@felia>
References: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Jul 2020, Mrinal Pandey wrote:

> The usage of "capture group (...)" in the immediate condition after `&&`
> results in `$1` being uninitialized. This issues a warning "Use of
> uninitialized value $1 in regexp compilation at ./scripts/checkpatch.pl
> line 2638".
> 
> I noticed this bug while running checkpatch on the set of commits from
> v5.7 to v5.8-rc1 of the kernel on the commits with a diff content in
> their commit message.
> 
> This bug was introduced in the script by commit e518e9a59ec3
> ("checkpatch: emit an error when there's a diff in a changelog"). It has
> been in the script since then.
> 
> The author intended to store the match made by capture group in variable
> `$1`. This should have contained the name of the file as `[\w/]+` matched.
> However, this couldn't be accomplished due to usage of capture group and
> `$1` in the same regular expression.
> 
> Fix this by placing the capture group in the condition before `&&`.
> Thus, `$1` can be initialized to the text that capture group matches
> thereby setting it to the desired and required value.
> 
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
> ---
> Changes since v1:
> Add Reviewed-by and Tested-by tag
>


Usually, the maintainers pick up those tags when they apply a patch to 
their tree, and the patch authors do not need to add those tags and resend 
the patch as a new version on the mailing list.

Mrinal, can you please go through and check the kernel documentation on 
submitting patches and find the places where it is pointed out that the 
maintainers usually apply those tags and the authors usually do not need 
to resend a new version of the patch with the tags applied?

If you cannot find such a statement in the documentation, please let us 
know where it would ideally added in the documentation. We can then create 
a patch for that together.


Lukas
