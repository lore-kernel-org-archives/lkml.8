Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AAFC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BEC206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588685560;
	bh=nOagl6uAd323E1GePcTCSBFA436BDC6z1ocoIZtcicE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wimBJfWDK6RRJUmvywdvNB3eW0Yl9TeAXdyl7f5UqmtSurSDZpMpvp5b3dkqnFLWq
	 G1NjXxE//1aeX7ipI2wsjJfkOj+7DdIN+UforvgJW+oL1Nf0YWAFQ9RLu2MZ9GAYTK
	 E68/k29j5PiLBwlZYSOCuh85ShOKP+lN5LvuER1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgEENck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:32:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43434 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbgEENck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:32:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id j16so1751425oih.10;
        Tue, 05 May 2020 06:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGzwYdYfDeCBheVXdcJg3XhWuww2Jcj8IasjcEOMoV0=;
        b=MR6I+DklNB4UWIma+YhYtDGiP/qik9dk5lDXhtsvBcl1ZZGYNS5sysTXpcCPRqm8GG
         TInab9/NjZatkLiTSUlVW5TjxT7wiIQ4jtg8+H76xQ1zY9KoDgM77LjoCWPeXZzH11lM
         PU7LLmJuIkt/1wDksXzahxHqKOKQOLXc/6ohjl0iL1rIehZL4B1eIQ7BXzRTr50pEa5O
         /ZEoc4uLEbqRxGUjNa2RzMv20kvfrBM7/z+mZ0jJvez2bz7n/wyiKQ+siP2zBkBHMCYy
         nlpA81DDB1DlCvnIJxnbpFV7CI/Gt6w2mRhi6FH7nYHtxh0svw5+R8MrcF94FAERvekW
         p/Vg==
X-Gm-Message-State: AGi0PuY+sgtv1pEGfs9uBWoUdRHO+UrO/NFQzdHmam9LMUoaewHDggIS
        cZLy6lrgOwgElvpRMmzS2+wq4wM=
X-Google-Smtp-Source: APiQypIAPbkEpcmAYhh8URn60kb6nxOuIrbrTxcDfwgGhqJijN2M8awvs8XkUUWZp//f+WPg20NRnA==
X-Received: by 2002:aca:7209:: with SMTP id p9mr2407871oic.168.1588685559210;
        Tue, 05 May 2020 06:32:39 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 1sm547503oir.5.2020.05.05.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 06:32:38 -0700 (PDT)
Received: (nullmailer pid 22806 invoked by uid 1000);
        Tue, 05 May 2020 13:32:37 -0000
Date:   Tue, 5 May 2020 08:32:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/2] dt-bindings: display: Document ASUS Z00T TM5P5
 NT35596 panel compatible
Message-ID: <20200505133237.GA22147@bogus>
References: <20200504200102.129195-1-konradybcio@gmail.com>
 <20200504200102.129195-3-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504200102.129195-3-konradybcio@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 May 2020 22:01:00 +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  .../display/panel/asus,z00t-tm5p5-n35596.yaml | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/display/panel/asus,z00t-tm5p5-n35596.yaml#

See https://patchwork.ozlabs.org/patch/1282986

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
