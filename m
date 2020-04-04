Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D8C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E8206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586019669;
	bh=5OFmxiVoCmVBqy5diJ09G/GGUCSa1tSBI7WL/e1C9WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mElfBNFWt+gigOtc42S79ahPmNoQuM7pBBkFVtVcAL8A6+UKU6cd+Ia2CUxmz909R
	 +Q4tpN5hnHq2iVqYVOzgqZ8I93cb/aOOYJ05X8go5uY94mLpshllsmdESNtjdlwW10
	 /T1nCiPBVhMIB7m/7Jo3AzBTK0bHg3jEY4b/qNec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDDRBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:01:07 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:44595 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDDRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:01:07 -0400
Received: by mail-io1-f43.google.com with SMTP id h6so1224045iok.11;
        Sat, 04 Apr 2020 10:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3QnbCRQ+OMyJ5TR+NLbh/l1h0t7JzVwEHPSm6WoW2A=;
        b=MS/YNzu0fOA3xASyLUOCH4oMoW3CxmN6JjV05M9JmdYIobpmDpwUTV86+Hz1mbWkvq
         B/JdmwqEXFhmFwWDczewcOsHlK3X7C9b9XhMron12UzUf1+T0dJtB9nQUVPjtSkfbG5K
         HmwN52gZXt0G3jZyauV5c92W812vHENduACOc5t1wiSiGSaLTdQxfSF0acL7ldoydiFh
         sd7s6DpIBbOpv++zUmyZsG8f7MLQzDQ4jplP1yfjjqXTK5Uq8cwhYjxyQjS43m1KyAfY
         95FVAyT5oFOxTD52uyJR3gITBUfSuPK8sSX9anCEoHNQgouIQyM5OH500bAHYCAm5oLV
         xy1w==
X-Gm-Message-State: AGi0PuZsLDrc37yaW2GrSbb59Iml1WeOwT6bpNJdU9al4glL7SQw72jT
        tQtfgW32CHuAO2S1CJtx/A==
X-Google-Smtp-Source: APiQypKwYcyLwX0Wb9G7R8uv+u7P+MQBJY18WS53VRC/llom69e5hbwh4TiXP7skB+jS0vodAp0mBA==
X-Received: by 2002:a02:c85b:: with SMTP id r27mr13256182jao.83.1586019665982;
        Sat, 04 Apr 2020 10:01:05 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l70sm4072094ili.81.2020.04.04.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 10:01:05 -0700 (PDT)
Received: (nullmailer pid 25897 invoked by uid 1000);
        Sat, 04 Apr 2020 17:01:04 -0000
Date:   Sat, 4 Apr 2020 11:01:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk@vger.kernel.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCHv5 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
Message-ID: <20200404170104.GA25196@bogus>
References: <20200403235403.13990-1-dinguyen@kernel.org>
 <20200403235403.13990-5-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403235403.13990-5-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 18:54:02 -0500, Dinh Nguyen wrote:
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v5: update license to GPL-2.0-only
>     Add additionalProperties
>     Add clock input for clkmgr
> v4: really fix build error(comment formatting was wrong)
> v3: address comments from Stephen Boyd
>     fix build error(tab removed in line 37)
>     renamed to intel,agilex.yaml
> v2: convert original document to YAML
> ---
>  .../bindings/clock/intel,agilex.yaml          | 40 +++++++++++
>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/intel,agilex.example.dt.yaml: clock-controller@ffd10000: 'clocks', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1266287

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
