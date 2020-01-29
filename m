Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59DEC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B149E20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYCTvlFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgA2KOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:14:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726177AbgA2KOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580292877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rlt0kehN3QF2KGB6VErLQgpui21PKLAlCENcJk6yot4=;
        b=TYCTvlFYF0tTGqpxmRBA8NVSCzlvTncNmPA679NGqnMKPbsrHI8P8SZ8BlswvwZQ3BQdOL
        HyKTHo27TfPPTmZCyxmVE24L1Yvqt/WiR5sHdcs3TUYr/w+r5v3DR+m0F+gXUrQPs1ENeX
        H0UZUm5epSH80kB5fW6kwP1pJw5RL9E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-d3srSm0kNlimRcKQdHaI7g-1; Wed, 29 Jan 2020 05:14:33 -0500
X-MC-Unique: d3srSm0kNlimRcKQdHaI7g-1
Received: by mail-qk1-f199.google.com with SMTP id k10so10290872qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 02:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rlt0kehN3QF2KGB6VErLQgpui21PKLAlCENcJk6yot4=;
        b=WBett5ViDj89O3sVd2cjOaTzt9Diu3M8GkPmcA0QYMRuwLD9q6fhB05S+GXjxpB7IR
         lIjXq1P8mzB9SPulLXyXnwFoiVmp2QjleXghaZpeouf6zShhliwyJbDK1U+Di3fjqcfv
         5t/nrSYAYnZzCKkr7wMAZ57cXdCVVKoj2wspvItSkTIt8XIaTV9XRJjLepphmrSmHa3n
         jFaDvxFXpz5B9iR+d7T6JSUR/+r3zYmOjJj/hYlE8hiDKZwTMz1YdUsl9CpAq7Pa41Q9
         czZmSMjKD5FVvLVd/2UZ62yBwUkWMLLQOMDyoCCEQenHxefWrHPoUFpzGHARZLtpdgq1
         Yu8g==
X-Gm-Message-State: APjAAAXCSuvDmDK2R4YhQFO2DtkVLvZPnWaLCo1Azvbab6tOxHvWvVTA
        jP16ZpzFg2Scnv1JiicJHMXo74zZ+TtrRj/UChX/ZnDgGOwbKOgtTBd5/cKPNdhwmVqUaZzE2C3
        xcQfDa3ZEevfw4MIRvzNIumo+
X-Received: by 2002:a05:620a:9d9:: with SMTP id y25mr26921918qky.41.1580292872798;
        Wed, 29 Jan 2020 02:14:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzu2nrf6QYNHZGHQeM1OSuRlOKDi4U7WT8rVBHghm4Kw8Lp8BSj2CHDFz+AxJ5ac8HvLU21LA==
X-Received: by 2002:a05:620a:9d9:: with SMTP id y25mr26921890qky.41.1580292872381;
        Wed, 29 Jan 2020 02:14:32 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
        by smtp.gmail.com with ESMTPSA id a24sm714862qkl.82.2020.01.29.02.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 02:14:31 -0800 (PST)
Date:   Wed, 29 Jan 2020 05:14:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jing Liu <jing2.liu@linux.intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v2 5/5] virtio-mmio: MSI vector and event
 mapping
Message-ID: <20200129051247-mutt-send-email-mst@kernel.org>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
 <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:54:33PM +0800, Jing Liu wrote:
> Bit 1 msi_sharing reported in the MsiState register indicates the mapping mode
> device uses.
> 
> Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per event and
> fixed static vectors and events relationship. This fits for devices with a high interrupt
> rate and best performance;
> Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and events
> dynamic mapping and fits for devices not requiring a high interrupt rate.

It seems that sharing mode is a superset of non-sharing mode.
Isn't that right? E.g. with sharing mode drivers
can still avoid sharing if they like.

Maybe it should just be a hint to drivers whether to share
interrupts, instead of a completely different layout?

> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>  content.tex | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  msi-state.c |  3 ++-
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index dcf6c71..2fd1686 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1770,7 +1770,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>    \hline
>    \mmioreg{MsiState}{MSI state}{0x0c4}{R}{%
>      When VIRTIO_F_MMIO_MSI has been negotiated, reading
> -    from this register returns the global MSI enable/disable status.
> +    from this register returns the global MSI enable/disable status
> +    and whether device uses MSI sharing mode.
>      \lstinputlisting{msi-state.c}
>    }
>    \hline
> @@ -1926,12 +1927,18 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>  mask and unmask the MSI vector applying to the one selected by writing
>  to \field{MsiVecSel}.
>  
> +VIRTIO_MMIO_MSI_CMD_MAP_CONFIG command is to set the configuration event and MSI vector
> +mapping. VIRTIO_MMIO_MSI_CMD_MAP_QUEUE is to set the queue event and MSI vector
> +mapping. They SHOULD only be used in MSI sharing mode.
> +
>  \begin{lstlisting}
>  #define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x1
>  #define  VIRTIO_MMIO_MSI_CMD_DISABLE          0x2
>  #define  VIRTIO_MMIO_MSI_CMD_CONFIGURE        0x3
>  #define  VIRTIO_MMIO_MSI_CMD_MASK             0x4
>  #define  VIRTIO_MMIO_MSI_CMD_UNMASK           0x5
> +#define  VIRTIO_MMIO_MSI_CMD_MAP_CONFIG       0x6
> +#define  VIRTIO_MMIO_MSI_CMD_MAP_QUEUE        0x7
>  \end{lstlisting}
>  
>  Setting a special NO_VECTOR value means disabling an interrupt for an event type.
> @@ -1941,10 +1948,49 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>  #define VIRTIO_MMIO_MSI_NO_VECTOR             0xffffffff
>  \end{lstlisting}
>  
> +\subparagraph{MSI Vector and Event Mapping}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization / MSI Vector Configuration}
> +The reported \field{msi_sharing} bit in the \field{MsiState} return value shows
> +the MSI sharing mode that device uses.
> +
> +When \field{msi_sharing} bit is 0, it indicates the device uses non-sharing mode
> +and vector per event fixed static relationship is used. The first vector is for device
> +configuraiton change event, the second vector is for virtqueue 1, the third vector
> +is for virtqueue 2 and so on.
> +
> +When \field{msi_sharing} bit is 1, it indicates the device uses MSI sharing mode,
> +and the vector and event mapping is dynamic. Writing \field{MsiVecSel}
> +followed by writing VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command
> +maps interrupts triggered by the configuration change/selected queue events respectively
> +to the corresponding MSI vector.
> +
> +\devicenormative{\subparagraph}{MSI Vector Configuration}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / MSI Vector Configuration}
> +
> +When the device reports \field{msi_sharing} bit as 0, it SHOULD support a number of
> +vectors that greater than the maximum number of virtqueues.
> +Device MUST report the number of vectors supported in \field{MsiVecNum}.
> +
> +When the device reports \field{msi_sharing} bit as 1, it SHOULD support at least
> +2 MSI vectors and MUST report in \field{MsiVecNum}. Device SHOULD support mapping any
> +event type to any vector under \field{MsiVecNum}.
> +
> +Device MUST support unmapping any event type (NO_VECTOR).
> +
> +The device SHOULD restrict the reported \field{msi_sharing} and \field{MsiVecNum}
> +to a value that might benefit system performance.
> +
> +\begin{note}
> +For example, a device which does not expect to send interrupts at a high rate might
> +return \field{msi_sharing} bit as 1.
> +\end{note}
> +
>  \drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / MSI Vector Configuration}
>  When VIRTIO_F_MMIO_MSI has been negotiated, driver should try to configure
>  and enable MSI.
>  
> +To set up the event and vector mapping for MSI sharing mode, driver SHOULD
> +write a valid \field{MsiVecSel} followed by VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
> +command to map the configuration change/selected queue events respectively.
> +
>  To configure MSI vector, driver SHOULD firstly specify the MSI vector index by
>  writing to \field{MsiVecSel}.
>  Then notify the MSI address and data by writing to \field{MsiAddrLow}, \field{MsiAddrHigh},
> diff --git a/msi-state.c b/msi-state.c
> index b1fa0c1..d470be4 100644
> --- a/msi-state.c
> +++ b/msi-state.c
> @@ -1,4 +1,5 @@
>  le32 {
>      msi_enabled : 1;
> -    reserved : 31;
> +    msi_sharing: 1;
> +    reserved : 30;
>  };
> -- 
> 2.7.4
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

