Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F07CC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EA520754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584571248;
	bh=JYLTD5cxDvSBSg++epIJgz0861zLlU3qBpM9i4/mDa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xfQQtdXNdlan3y+0w3N59LXwi+myt/Hmb5/2kqV3nkqP7JLbnWoNp2Ts2a/lfv262
	 K1ULQgF0IcGZUl4+Qz3A+H9aQLI7a3Kt2mH58QkHoY7bDroi3u3x14qen+sc0JGnVN
	 eURAJBqkQXlkQr2ynzi3MZP/B9lZE5CvHa8Ye1bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCRWkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:40:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32782 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgCRWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:40:47 -0400
Received: by mail-io1-f65.google.com with SMTP id o127so295443iof.0;
        Wed, 18 Mar 2020 15:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNmWTWISSY3HxnGdq3YlFpG87OzVoepE1NIhZFHW6Vg=;
        b=Dd5pLMyjVNfBimEg2D9VA0zt8/yznPgyK9Lo5mVftDF2IzTLB798EqYEyh0yaVPZuv
         2eIKCNeNED5UkHLsx/Rx30uHd1m1Zgc/Qdhp8O1LvoNWb3ZF8slTmbfyvbyM8ncjtBI6
         ylJ3jFtjQ1X3z8TZqLWVJyrJS6EX48vECwS9UHTft/wmcGyymoc9Vc5RwmgpeNje9JKg
         A0DkFds4X874h5nWBvOLEt6G8fLusazswXCuIOCjKPpcFWiktAA+tDvzB+VJCGag2Fco
         j7K7HXybcBGM8DLHrNqzXlEG69b+IAYWvC9W1F/uqmbzuuqXOlvRKFR/H2lDt6TU03Iw
         HSYQ==
X-Gm-Message-State: ANhLgQ22tp7wyVNiayUXeeNSJOzvktFn/x0bV4v4gZ569XJlac3oh+nN
        2+Tqb65I5Aw191jV8yX7xw==
X-Google-Smtp-Source: ADFU+vueJ8UutJsifakMHvpGq04AYZ7HzoPPa9jyc6D+mpX3xmSiVDrOgMu8lAqgI6eznnw6v065Ag==
X-Received: by 2002:a5d:980f:: with SMTP id a15mr34849iol.203.1584571246003;
        Wed, 18 Mar 2020 15:40:46 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b62sm101487ilb.1.2020.03.18.15.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:40:44 -0700 (PDT)
Received: (nullmailer pid 2596 invoked by uid 1000);
        Wed, 18 Mar 2020 22:40:42 -0000
Date:   Wed, 18 Mar 2020 16:40:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk@vger.kernel.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCHv3 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
Message-ID: <20200318224042.GA32101@bogus>
References: <20200317161022.11181-1-dinguyen@kernel.org>
 <20200317161022.11181-5-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317161022.11181-5-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 11:10:21 -0500, Dinh Nguyen wrote:
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: address comments from Stephen Boyd
>     fix build error(tab removed in line 37)
>     renamed to intel,agilex.yaml
> v2: convert original document to YAML
> ---
>  .../bindings/clock/intel,agilex.yaml          | 36 ++++++++++
>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/clock/intel,agilex.example.dts:17.3-4 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/clock/intel,agilex.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/clock/intel,agilex.example.dt.yaml] Error 1
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1256630
Please check and re-submit.
