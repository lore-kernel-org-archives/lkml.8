Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FF8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C202206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5OI7GP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDFVAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:00:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41837 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFVAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:00:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id a24so8189277pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kN7EdV3TB2LLwhC8lF0q0y2wPgwg6vmGC+AEPO56+lI=;
        b=Y5OI7GP+UE/pkAz0PiB49QC8C9Lg9D7fVn9yeeNUyNHKhQQ/9WYAXMY6P8Uu2JME+7
         4Z2CYR1UJoEeDZbbPOQSn6H5ivkq2JXiU2G3WZBfz62usKvfhqYp0Jnxot1rDlRVsWS+
         YW9kneDpHtG5gmywhyAShXe/1B/TWpN+YGr5z9t6JD/n9hHHVWFeruzOsfhXHEq3B0RU
         aQl8F2wD9lDpWBVC1bbUUhDBhNnEI4k1u0ngX3J0cswd0Po++83Y1l/GslOJCjgVGgtL
         YnFQxQsjtoxF6qKvDuRrpmG2tijTCz6dAQdzudtocrFO46noFpS8SxBJ6ixq1Q9glGGk
         xpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kN7EdV3TB2LLwhC8lF0q0y2wPgwg6vmGC+AEPO56+lI=;
        b=K2LSW1FNW2yfQukxx4ZtTKheAZmyyCJJdY6KyaKR/QYSwQOrzyn73wP2eQrSTJ6yeO
         +hZHVethBijaQdGEV1gPb+v3+dKHPtgx5VKflHtjTfEK6kkGqu9rYcEi2IzSvWfN2A7l
         HTD9LTDbMlY+SFNQUCZrMLfvT0lSXfeNXE2y4AuG4WhB+58iJR+JBc4p4+3VmZGFI6Ls
         AlckOqyergTydLnUN6j9zLJ8L/mMCzZxGanQCnNNimedxdAUjtaJnSEjQMVemT4Yizo3
         FsIU3G2mbdlWEuOfxGHniEf3mrJjx59YIz977aCiG3NnFFBaxfGUVvgIgeB+wr5STlf3
         byaw==
X-Gm-Message-State: AGi0PuaAskINA0HvNuiHpHrtUdXs7GOaHCC74Oes4iKpChYBVnf3ZWfI
        hWnb8QbSNhfTvLSwyQKmHAI=
X-Google-Smtp-Source: APiQypIltXLyrYZ7Y0t4XNDZFTS4Xd3NXqK9KUWvQSVVWrmDozS8CK0rmTYZ8Thgsxsqf1eR+tKF4Q==
X-Received: by 2002:a63:78e:: with SMTP id 136mr929138pgh.181.1586206849172;
        Mon, 06 Apr 2020 14:00:49 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q6sm447085pja.34.2020.04.06.14.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 14:00:48 -0700 (PDT)
Date:   Mon, 6 Apr 2020 14:00:51 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     m.szyprowski@samsung.com, hch@lst.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC/RFT][PATCH] dma-mapping: set default segment_boundary_mask
 to ULONG_MAX
Message-ID: <20200406210050.GA20495@Asurada-Nvidia.nvidia.com>
References: <20200405005157.1318-1-nicoleotsuka@gmail.com>
 <c984d2ea-6036-a8ae-97df-b5178a2a9ab9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c984d2ea-6036-a8ae-97df-b5178a2a9ab9@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:48:13PM +0100, Robin Murphy wrote:
> On 2020-04-05 1:51 am, Nicolin Chen wrote:
> > The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
> > a decade ago by referencing SCSI/block subsystem, as a 32-bit
> > mask was good enough for most of the devices.
> > 
> > Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
> > while only a handful of them call dma_set_seg_boundary(). This
> > means that most drivers have a 4GB segmention boundary because
> > DMA API returns a 32-bit default value, though they might not
> > really have such a limit.
> > 
> > The default segment_boundary_mask should mean "no limit" since
> > the device doesn't explicitly set the mask. But a 32-bit mask
> > certainly limits those devices capable of 32+ bits addressing.
> > 
> > And this 32-bit boundary mask might result in a situation that
> > when dma-iommu maps a DMA buffer (size > 4GB), iommu_map_sg()
> > cuts the IOVA region into discontiguous pieces, and creates a
> > faulty IOVA mapping that overlaps some physical memory outside
> > the scatter list, which might lead to some random kernel panic
> > after DMA overwrites that faulty IOVA space.
> 
> Once again, get rid of this paragraph - it doesn't have much to do with the
> *default* value since it describes a behaviour general to any boundary mask.
> Plus it effectively says "if a driver uses a DMA-mapped scatterlist
> incorrectly, this change can help paper over the bug", which is rather the
> opposite of a good justification.

Np. Will drop it and resend.

> (for example most SATA devices end up with a 64KB boundary mask, such that
> padding the IOVAs to provide the appropriate alignment happens very
> frequently, and they've been working just fine for years now)

Okay.

Thanks!
