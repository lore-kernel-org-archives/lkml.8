Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C86C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAB1206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1etfOK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHLEnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgHLEnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:43:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:43:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 77so1010229qkm.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=rJgrLSyPdqItlX390TtkEupGeCAynoZXuPZIpOgMg8g=;
        b=T1etfOK9vyL/pFR86O/Ro61bfgZaKs+C7SK9AkCphZWD+TjZ+RHwr7j9p3NUcuQLTA
         5tVBtqPXo0fyWftA02iaGtxgCNhUG+gD+qMvXFhUStINogiecxczPOixqU8YNknuVWkG
         zt7pDP0WLRdv+FwtEpAnNgpT4RF9H74UDPK3p/cpRjnEU9VIlILzIN6rIG2fmyNrpOma
         hznAnHC5WPTkfqHbpsIS7ipxzI3jiNPNeakv8jCDCvYwVXmBfaEu7N742z8+vYJANAUV
         HxTECk+SNW/gbtkigfAQSu+OG16OO0TgYO3H8xOCVdl+yTDG/LNEIX3wQXx/uOI1OQdi
         Jinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rJgrLSyPdqItlX390TtkEupGeCAynoZXuPZIpOgMg8g=;
        b=BtPD9FNTUpYWG7npFfisyVibq9Is5H6s4FwB3zpFMK1Xvb3ncfrEakZUBVTGDzmMvz
         EIutJdndg1YQJlW1ZS4dXwouyahhYdW42jal8uGCls8gV7FE+2S77odGMtn9AoC2JuCb
         wSrcw9ku/KJEq86QJ9BNh2PC+gKDI18nJK4VsBm7waXAq8THHOMhFMfrlgrUpbIUSwWr
         7ieLVTIREe8gtqrP/OfL+6+QJQOcR4sChQSu+UYs5vofNV7RPjDXEPe3RPFjPTjOyeS/
         On9nGq6RAbZHAkGA9pLS+hMR/JWix15B5xc3NrFB6/LwuZ+bjfsH3l6aA7TSVboVO0cj
         +dXw==
X-Gm-Message-State: AOAM531ltEPXAKd4ALsMJwYgy5H7Shgx4CHFQb6iLThskm4uus0/mmnF
        7fm2WtPr50ZXDGsiskZQxMYC5F5/
X-Google-Smtp-Source: ABdhPJwLxgEw+Q6iFnIConOqLBIVUHovAuGXnEwEQsCuzQ1XQ/D/krtxWAM5HMBnePva1T2B72QQhA==
X-Received: by 2002:ae9:e505:: with SMTP id w5mr4276341qkf.282.1597207383233;
        Tue, 11 Aug 2020 21:43:03 -0700 (PDT)
Received: from LeoBras ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id o72sm963097qka.113.2020.08.11.21.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 21:43:02 -0700 (PDT)
Message-ID: <4edd762ee53060db6ae3d58aa45ea25887c04a47.camel@gmail.com>
Subject: Re: [PATCH v5 0/4] Allow bigger 64bit window by removing default
 DMA window
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Aug 2020 01:42:56 -0300
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

Do you suggest any change for this patchset?
Any chance it can get in this merge window?

Best regards,
Leonardo Bras

On Wed, 2020-08-05 at 00:04 -0300, Leonardo Bras wrote:
> There are some devices in which a hypervisor may only allow 1 DMA window
> to exist at a time, and in those cases, a DDW is never created to them,
> since the default DMA window keeps using this resource.
> 
> LoPAR recommends this procedure:
> 1. Remove the default DMA window,
> 2. Query for which configs the DDW can be created,
> 3. Create a DDW.
> 
> Patch #1:
> Create defines for outputs of ibm,ddw-applicable, so it's easier to
> identify them.
> 
> Patch #2:
> - After LoPAR level 2.8, there is an extension that can make
>   ibm,query-pe-dma-windows to have 6 outputs instead of 5. This changes the
>   order of the outputs, and that can cause some trouble. 
> - query_ddw() was updated to check how many outputs the 
>   ibm,query-pe-dma-windows is supposed to have, update the rtas_call() and
>   deal correctly with the outputs in both cases.
> - This patch looks somehow unrelated to the series, but it can avoid future
>   problems on DDW creation.
> 
> Patch #3 moves the window-removing code from remove_ddw() to
> remove_dma_window(), creating a way to delete any DMA window, so it can be
> used to delete the default DMA window.
> 
> Patch #4 makes use of the remove_dma_window() from patch #3 to remove the
> default DMA window before query_ddw(). It also implements a new rtas call
> to recover the default DMA window, in case anything fails after it was
> removed, and a DDW couldn't be created.
> 
> ---
> Changes since v4:
> - Removed patches 5+ in order to deal with a feature at a time
> - Remove unnecessary parentesis in patch #4
> - Changed patch #4 title from 
>   "Remove default DMA window before creating DDW"
> - Included David Dai tested-by
> - v4 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=190051&state=%2A&archive=both
> 
> Changes since v3:
> - Introduces new patch #5, to prepare for an important change in #6
> - struct iommu_table was not being updated, so include a way to do this
>   in patch #6.
> - Improved patch #4 based in a suggestion from Alexey, to make code
>   more easily understandable
> - v3 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=187348&state=%2A&archive=both
> 
> Changes since v2:
> - Change the way ibm,ddw-extensions is accessed, using a proper function
>   instead of doing this inline everytime it's used.
> - Remove previous patch #6, as it doesn't look like it would be useful.
> - Add new patch, for changing names from direct* to dma*, as indirect 
>   mapping can be used from now on.
> - Fix some typos, corrects some define usage.
> - v2 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=185433&state=%2A&archive=both
> 
> Changes since v1:
> - Add defines for ibm,ddw-applicable and ibm,ddw-extensions outputs
> - Merge aux function query_ddw_out_sz() into query_ddw()
> - Merge reset_dma_window() patch (prev. #2) into remove default DMA
>   window patch (#4).
> - Keep device_node *np name instead of using pdn in remove_*()
> - Rename 'device_node *pdn' into 'parent' in new functions
> - Rename dfl_win to default_win
> - Only remove the default DMA window if there is no window available
>   in first query.
> - Check if default DMA window can be restored before removing it.
> - Fix 'unitialized use' (found by travis mpe:ci-test)
> - New patches #5 and #6
> - v1 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=184420&state=%2A&archive=both
> 
> Special thanks for Alexey Kardashevskiy, Brian King and
> Oliver O'Halloran for the feedback provided!
> 
> 
> Leonardo Bras (4):
>   powerpc/pseries/iommu: Create defines for operations in
>     ibm,ddw-applicable
>   powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
>   powerpc/pseries/iommu: Move window-removing part of remove_ddw into
>     remove_dma_window
>   powerpc/pseries/iommu: Allow bigger 64bit window by removing default
>     DMA window
> 
>  arch/powerpc/platforms/pseries/iommu.c | 242 ++++++++++++++++++++-----
>  1 file changed, 195 insertions(+), 47 deletions(-)
> 

