Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B661C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EF22073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nkAMZOGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgEGPLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgEGPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:11:02 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD9C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 08:11:02 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x6so3667043vso.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RndLXpjGcg2BFmdbethLGIwu7OqaNE0mD4rRGU8RVzc=;
        b=nkAMZOGNPKlk7/n/u8CYJjF3Syua63LITwI5bpol7Mqr6TTXkvZw6dqszUIx/ap1/B
         2dZmgFSOZ9u78AywiwqogbB9v4eKI4IMaebLSxRBporBGtdbS4hwzV2kX5nAjoCwY71n
         B0oR0yhSAs/RGthRqb1FqMAneLaVwGi1i4tdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RndLXpjGcg2BFmdbethLGIwu7OqaNE0mD4rRGU8RVzc=;
        b=TZLuLDhSIr7NJOLhW+dkVtOoTDPRgV0bUpRbGP3YLTw3+z5NUWPOhqOoWcNfVTyCWl
         nCRGh6I91cGeFCzN3sAheOd83dci1hJDJscurU9zrqk5T0Kst74Uosar0yAEZD0dY/i6
         73PZFAPJhf7uyoBUgK/XLGgCoz3RGwvPiEPPu5Yj1NH1vqSPWeFEucl+bF6+7//1CPIE
         h0MXMaKt0QnWVwPrNSnpDg/Lw0A6DE0uJhP+qDZ6jq6UPVhinH0R8YvYc20znbdYQIME
         uJEuvwHuhylj6sWwzm3UtO3F1UtdpoVuLlQ7OvROCEmW//sd5bjA0nQmLRdO4udd2EcB
         XbiA==
X-Gm-Message-State: AGi0Pubp9W+RLxIx1BtUc3rYmOs60CstJETQeXv2plOQA/Qot54+zt7Y
        8g+Gpmhdk7l5OtVn1I5AQykHBYZjey4=
X-Google-Smtp-Source: APiQypJfUONTw9gDoGXveI3NB49r3wKnyC2XEdmjpl0gXNrJsjzQ2OWF+tt8/rbK9e3L8zWhAW0MmQ==
X-Received: by 2002:a67:2dcb:: with SMTP id t194mr12733157vst.136.1588864260948;
        Thu, 07 May 2020 08:11:00 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id l192sm271277vsd.15.2020.05.07.08.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 08:11:00 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id v23so1563793vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 08:11:00 -0700 (PDT)
X-Received: by 2002:a1f:c643:: with SMTP id w64mr12224571vkf.0.1588864259688;
 Thu, 07 May 2020 08:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200507110649.37426-1-yanaijie@huawei.com>
In-Reply-To: <20200507110649.37426-1-yanaijie@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 May 2020 08:10:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wp-L_oYsb1N4O6VC-NN5Ht2+J8S5o7AJgOk==quhHstA@mail.gmail.com>
Message-ID: <CAD=FV=Wp-L_oYsb1N4O6VC-NN5Ht2+J8S5o7AJgOk==quhHstA@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Return true in kgdb_nmi_poll_knock()
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 7, 2020 at 4:07 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following coccicheck warning:
>
> include/linux/kgdb.h:301:54-55: WARNING: return of 0/1 in function
> 'kgdb_nmi_poll_knock' with return type bool
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  include/linux/kgdb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
