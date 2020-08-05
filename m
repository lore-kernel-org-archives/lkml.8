Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14A222CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFmxb7f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgHEFP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEFP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:15:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20B8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 22:15:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so12210514pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 22:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/n77pfE4a+GOKvicmljT/QtRWcD5OcaFIdllbQ5Y/wY=;
        b=AFmxb7f8d9u4khyrON5HeLJwb1Qw5QvNvEXE0doBoJbYvgEvXafs8WeN9n7auMuuAF
         VXPoMIf1mSknY/cVdcBCMW8L6eBpi4J7dwrN5Zi5PLjH2PUm8Lm7V2AYxw+rb8ThXBik
         KLVB5HrUo+2v2qtsNCpehTNZab+H5ACdib6DdIPEi78GG/7snFgF+lh5TBGT6HNOd3xU
         ynDWad+UVkv0Xo5MvddZnnu5tENt9XHaqz9D1HtZzAGoWAnepvaHLfsVnBRgKBv6RWsk
         USORzkHoGh/7EGz5XAWvITM5OjG1m4qrxdoQSKJAubGvkJ+0kEmsUD31VGsdMKqjH5++
         mSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/n77pfE4a+GOKvicmljT/QtRWcD5OcaFIdllbQ5Y/wY=;
        b=jylU1EaeS4nLBF25OwsBAj+7bXv0lymH71MzS8QTq36lf3dY2qA/L852dXSTPixDj1
         Q2Decygf3/FAs+jPSFeCZMfXDzZsC51bDO6bJIdXMYSNenPJM9JYO5fnMFYLp9NSdbkr
         IR7TDLk32FdDGWLkkFbK9nppEBSFRb40bSqxDpD2ztXDiQdgPXcv+pZ70WVCABxWxyq9
         A4I30kTLz+K8Q9ckGmhXQj+vZMbIB9BwPCKn2sgZnMqpOm14vA5FdorgodOcX58tIYFM
         tqc1i4J3fjn0mSUyMRGLiQIeC8l7WwuIPpLwRtLo/SnOMn8/YQ7N3/VPGHAWxF3S/ctc
         WW0Q==
X-Gm-Message-State: AOAM5318gPqf05LtPrCIBR9R91PWFAlS69Nw9rM+EBNpmuXlOUKHHZk8
        RX78uTdvE8DV4i3+r7npKjc=
X-Google-Smtp-Source: ABdhPJznedC2BZI3gT80R+gKb4MGfnESYyp4nkwqsAQ81pws/5kKeVDVr8qut1B0dpAbnle7RGQ0Gw==
X-Received: by 2002:a05:6a00:14d3:: with SMTP id w19mr1664143pfu.92.1596604526362;
        Tue, 04 Aug 2020 22:15:26 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h5sm1322799pfq.146.2020.08.04.22.15.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 22:15:26 -0700 (PDT)
Date:   Tue, 4 Aug 2020 22:15:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_sai: Refine enable and disable sequence
 for synchronous mode
Message-ID: <20200805051511.GA29129@Asurada-Nvidia>
References: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
 <1596594233-13489-3-git-send-email-shengjiu.wang@nxp.com>
 <20200805041111.GB10174@Asurada-Nvidia>
 <CAA+D8ANv-qURC_wu3TzWiiiCAXC88Gc+WGssdjmuWoLPTRm3pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANv-qURC_wu3TzWiiiCAXC88Gc+WGssdjmuWoLPTRm3pA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 01:03:37PM +0800, Shengjiu Wang wrote:
> > Btw, the new fsl_sai_dir_is_synced() can be probably applied to
> > other places with a followup patch.

> Do you mean move it to the beginning of this file?

There are other existing places testing "sync[tx] && !sync[!tx]"
so you may submit another change to replace them. But, yea, will
be a good idea to move that helper function to the top.
