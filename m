Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ACEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A292177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGT1CbGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgH0MzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgH0Mym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:54:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A0C061264;
        Thu, 27 Aug 2020 05:54:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a65so5064001wme.5;
        Thu, 27 Aug 2020 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a5lpHFvSWQoGrjybaXmlV69Axq+442tGTTEhKXzXB/M=;
        b=FGT1CbGRN8nWIZimQQJFHaFlgGbXUWXcohmF6aYnzTMEIdoXLV8ASHcjH/rftf8dPu
         05h7ynqky+tK0sVnESIUNMOkwDJXKaIKOOjfk8ZzK2aS6ItFzfPK1RiS8Sgq9gCPkksa
         s87z1TYPj+YUb/w6uaLEL+ETfgmlzhXCU10ucGJlzNXsBINUdbYoCrfyflOTHYw+cbz4
         RAdiDof8rxMnyZ5hwply2FrDERb1PY3A2wl1RdJOsOW1zwqi8pXPitwO0zzOFjipVey5
         oUPQnIgnx+nqlo3zwpUr7dRtVO/mC+2RV5+VHT1jDZZ+PWuU7gSvtmMNjL2CWO/kpKhp
         IGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a5lpHFvSWQoGrjybaXmlV69Axq+442tGTTEhKXzXB/M=;
        b=MJE0yRwoQzsnxhBdyQfT/5MJsLRMJJNbLzi6l5vW6qxHl5bqRp/XIPtRcshfhf1MXi
         ylS/yD4UhWjMvhOPZHiOUs34DMwd3ylguODBJMUWyPTfH/BopgBdvZoWr6ulu4PuP+qe
         PSJg+eQXemuAwlNiNq9hCnsrI3g41k+OsE+klK1Dq0pCO7n6T2gONMN+jQtgwl/Awrag
         s0leS9JW4OhpgpJev6w9NZUvE1UHPaNEfgwgrXhRRJKJo219VmJNPxwKHorUR+4ardYd
         5TGqVnuDjEDAObVVoAoW+NexE/QJex7LwaKZbSR5fiz0RZIIYEuHf8Wt4YHYadvfqj/3
         rNTg==
X-Gm-Message-State: AOAM530XMfU3U+EJgb0wemg2LzY3pj35cT57QRmYtFb/CbltHCsXBKw3
        rzSZ80YqV2s8TTs0/YOtSp/HI5Ab9ROw9zwo
X-Google-Smtp-Source: ABdhPJwqZV7pk1FvOSkguIjKJvFkFK+Tun3miq523wTMnXd9BGquVzYW29lvsrXbzl2PtJrmqLojuA==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3074513wmc.100.1598532878977;
        Thu, 27 Aug 2020 05:54:38 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
        by smtp.gmail.com with ESMTPSA id m11sm5436719wrn.11.2020.08.27.05.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 05:54:38 -0700 (PDT)
Subject: Re: Aw: [PATCH 00/18] Convert arch/arm to use iommu-dma
To:     Frank Wunderlich <frank-w@public-files.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, joro@8bytes.org, linux@armlinux.org.uk,
        geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
        bjorn.andersson@linaro.org, thierry.reding@gmail.com,
        laurent.pinchart@ideasonboard.com, digetx@gmail.com, s-anna@ti.com,
        will@kernel.org, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
        kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
        yong.wu@mediatek.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, inki.dae@samsung.com,
        vdumpa@nvidia.com, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
        t-kristo@ti.com, iommu@lists.linux-foundation.org
References: <cover.1597931875.git.robin.murphy@arm.com>
 <trinity-d6be65d8-9086-42bc-b993-238b731cdf60-1598531519064@3c-app-gmx-bap26>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d54f5d47-63aa-d07e-3875-6acce69073f3@gmail.com>
Date:   Thu, 27 Aug 2020 14:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-d6be65d8-9086-42bc-b993-238b731cdf60-1598531519064@3c-app-gmx-bap26>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2020 14:31, Frank Wunderlich wrote:
> Tested full series on bananapi r2 (mt7623/mt2701, 5.9-rc1 + hdmi-patches), works so far fbcon+x without issues
> 
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> 

Thanks for testing.

Robin this is especially relevant for:
[PATCH 09/18] iommu/mediatek-v1: Add IOMMU_DOMAIN_DMA support

Regards,
Matthias
