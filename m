Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E35C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E7424670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582124744;
	bh=KLCNhehFoLS2QtbJ8R1nLapFTT9x/0GfRUKaDGhtdf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V73nhxib55O3kh6jaAN7+18L0CPDtHN4ZvV+VYLm4ZRbWImJVrUc4GisjovHE3psY
	 THWkOMKr6Z6G3LgsyE+vxd+MUJrkN9zlnKf2KXhl/il7KDbxYEPZJQPSUlM0dgV5O8
	 zyd8VqQX7UdKQnVStgIgFSmeobSyHfwzKPmKMzxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBSPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:05:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40051 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgBSPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:05:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so416207otr.7;
        Wed, 19 Feb 2020 07:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBKr6SKoCafYNmFC5MjIcmPvtNTyDNU/puwE+3je3yw=;
        b=IAnoSWehFEL7vMivpe+ZE1ANDz7gZ/bdBTA04+nX9+Rl6F9sO5SWVt+BUnbARhwM2p
         tnVLpIU9E6I9UIpXQSWj4yUPnsgaGii+WYOZ1VENO4QypcCK4uO2pbDGc9ejst2BcyTo
         LAdwly7gNbCQKHvnyQyihxP8HnVnUItJFgb4NbSDFCJAvhhS/uda0g+TtS1ImpzEasLg
         QNNjhjZNnXOgtaB43akoPHVI08PtHPj+8TlyXZ2t/mLpXr771/DeowLPdgwddLuTr8oa
         pckvKx2AKuzl7KQFKUkB6uXUOadUcwwgLyl0kCA7LbEFL+eQU1drHR5kbtDEOiDDGAaP
         CMJw==
X-Gm-Message-State: APjAAAUqHAdeElqJTE7XHontWhQOGz8wUwJxYdT959tjHVeuZAZtP5Xe
        wOacm3hf+smUQC0qJspXtQ==
X-Google-Smtp-Source: APXvYqzQfbs3yejJP7JC1NIdQfNXPIqC6m0QklCphdJhvqRhtoYtKQhsaQx+0uOvCILhD83U6NqKKQ==
X-Received: by 2002:a9d:7357:: with SMTP id l23mr19144503otk.10.1582124742732;
        Wed, 19 Feb 2020 07:05:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm3046otp.10.2020.02.19.07.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:05:41 -0800 (PST)
Received: (nullmailer pid 22736 invoked by uid 1000);
        Wed, 19 Feb 2020 15:05:41 -0000
Date:   Wed, 19 Feb 2020 09:05:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com
Subject: Re: [PATCH v2] ASoC: dt-bindings: stm32: convert i2s to json-schema
Message-ID: <20200219150541.GA22679@bogus>
References: <20200207120345.24672-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207120345.24672-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 13:03:45 +0100, Olivier Moysan wrote:
> Convert the STM32 I2S bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes in v2:
> - Define items order for clock and dma properties
> ---
>  .../bindings/sound/st,stm32-i2s.txt           | 62 -------------
>  .../bindings/sound/st,stm32-i2s.yaml          | 87 +++++++++++++++++++
>  2 files changed, 87 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
