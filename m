Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D98720705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVH/kKI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEDUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:16:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D21C061A0E;
        Mon,  4 May 2020 13:16:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b188so10073qkd.9;
        Mon, 04 May 2020 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJ8VQaYj0j4FHg/jrxGw2s3eycLlJxVblYg75nGvgVQ=;
        b=eVH/kKI8QTF2ch7K0Z8VRfbF3YpS9lLeO+o+B2FrPF3aMw0aJmXsC/RAylRAJOun8D
         3kodLsyw1saRMHild06CIgnHkDGTStk8/92rJAF8RFTNHQF5b0eynCzSJt+1gqWBICEv
         l1+U3dPXaqTpM6dN2IxPD3TijfvX3DI1GFP6G059K1iGDMFsTxWupBfJX46rjXkAPbxC
         54vfzetfQqwSt9epLrTdzCDZDvCHY5ULDp+Pl8Gbg2JDgtRTzgUJMWdQ3ubAKJdCI65t
         UcmEJBscT652ecHLOJ6MqP4B3nFPaZB8HXxE1NsViq1EqfLJV8HrEKygkRWHP7WLBqvd
         jsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJ8VQaYj0j4FHg/jrxGw2s3eycLlJxVblYg75nGvgVQ=;
        b=jcDfBGgjPxQc904hZV9Ki3k1zUbpQelVQff2+xfoqEbjw0hexaqJWcsAn0U87JegQj
         U1hXa2CNKYLTopcOy3/gOz9jFV02cELXwllaSuoOXf/tmRByWq4egj9qnuOHCLz/+bp4
         UFE4PUYXUZoZchdnNq/6D10SHmSJPjC6WbxZpDFY77dHhltJvdtZzQX0ozsbRUXEqkJ/
         LiSvToTs2A1+Kmsr/pwnU0+i5rfCsJ//hbVvAroihuZMBKvm/UdUdRLX3y824/VuIp30
         Q7PqUpVCp4mTy2SJtacqsoHP2UCuHYPOubladInd/iq+v70IQww/fYYke0IhO0o3NFe0
         /E6w==
X-Gm-Message-State: AGi0Pubtlqcv14qgupoGXr6oa/2FVzxAagDMVoOWT5FX8e3zdbWLHI48
        AL989G+fR3OW0Sjk3Qn36xc=
X-Google-Smtp-Source: APiQypJ76ueRCQH94hlywgK6ulDNVK2bkDabPYwDltZj04QZDKEJPBzWmjet/fDK5ryd9F+jm7KuyQ==
X-Received: by 2002:ae9:ebc8:: with SMTP id b191mr86028qkg.1.1588623402720;
        Mon, 04 May 2020 13:16:42 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id o6sm63393qkj.126.2020.05.04.13.16.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 13:16:42 -0700 (PDT)
Subject: Re: [PATCH v2] of: Documentation: change overlay example to use
 current syntax
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
Message-ID: <03f21610-895f-7223-806b-23c002c6f047@gmail.com>
Date:   Mon, 4 May 2020 15:16:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Ping.

There is a conflict between this and Mauro's v3 patch at:

  https://lore.kernel.org/r/cover.1586961793.git.mchehab+huawei@kernel.org

I pointed out the conflict to Mauro in his v2 patch, and he said he would
rebase on a new -next to resolve the conflict.  Unfortunately my patch
was not in -next, so the conflict remains.

If Mauro's patches should go in first, I can redo my patches on top of
his, after his go in.

-Frank

On 1/27/20 6:37 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The overlay implementation details in the compiled (DTB) file are
> now properly implemented by the dtc compiler and should no longer
> be hard coded in the source file.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes since v1:
>   - fixed typo in patch comment (implementation)
> 
>  Documentation/devicetree/overlay-notes.txt | 85 ++++++++++++------------------
>  1 file changed, 35 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
> index 725fb8d255c1..fddc63da7dba 100644
> --- a/Documentation/devicetree/overlay-notes.txt
> +++ b/Documentation/devicetree/overlay-notes.txt
> @@ -19,6 +19,7 @@ Lets take an example where we have a foo board with the following base tree:
>  
>  ---- foo.dts -----------------------------------------------------------------
>  	/* FOO platform */
> +	/dts-v1/;
>  	/ {
>  		compatible = "corp,foo";
>  
> @@ -30,30 +31,25 @@ Lets take an example where we have a foo board with the following base tree:
>  		ocp: ocp {
>  			/* peripherals that are always instantiated */
>  			peripheral1 { ... };
> -		}
> +		};
>  	};
>  ---- foo.dts -----------------------------------------------------------------
>  
> -The overlay bar.dts, when loaded (and resolved as described in [1]) should
> +The overlay bar.dts,
>  
> ----- bar.dts -----------------------------------------------------------------
> -/plugin/;	/* allow undefined label references and record them */
> -/ {
> -	....	/* various properties for loader use; i.e. part id etc. */
> -	fragment@0 {
> -		target = <&ocp>;
> -		__overlay__ {
> -			/* bar peripheral */
> -			bar {
> -				compatible = "corp,bar";
> -				... /* various properties and child nodes */
> -			}
> +---- bar.dts - overlay target location by label ------------------------------
> +	/dts-v1/;
> +	/plugin/;
> +	&ocp {
> +		/* bar peripheral */
> +		bar {
> +			compatible = "corp,bar";
> +			... /* various properties and child nodes */
>  		};
>  	};
> -};
>  ---- bar.dts -----------------------------------------------------------------
>  
> -result in foo+bar.dts
> +when loaded (and resolved as described in [1]) should result in foo+bar.dts
>  
>  ---- foo+bar.dts -------------------------------------------------------------
>  	/* FOO platform + bar peripheral */
> @@ -73,8 +69,8 @@ result in foo+bar.dts
>  			bar {
>  				compatible = "corp,bar";
>  				... /* various properties and child nodes */
> -			}
> -		}
> +			};
> +		};
>  	};
>  ---- foo+bar.dts -------------------------------------------------------------
>  
> @@ -82,6 +78,27 @@ As a result of the overlay, a new device node (bar) has been created
>  so a bar platform device will be registered and if a matching device driver
>  is loaded the device will be created as expected.
>  
> +If the base DT was not compiled with the -@ option then the "&ocp" label
> +will not be available to resolve the overlay node(s) to the proper location
> +in the base DT. In this case, the target path can be provided. The target
> +location by label syntax is preferred because the overlay can be applied to
> +any base DT containing the label, no matter where the label occurs in the DT.
> +
> +The above bar.dts example modified to use target path syntax is:
> +
> +---- bar.dts - overlay target location by explicit path ----------------------
> +	/dts-v1/;
> +	/plugin/;
> +	&{/ocp} {
> +		/* bar peripheral */
> +		bar {
> +			compatible = "corp,bar";
> +			... /* various properties and child nodes */
> +		}
> +	};
> +---- bar.dts -----------------------------------------------------------------
> +
> +
>  Overlay in-kernel API
>  --------------------------------
>  
> @@ -105,35 +122,3 @@ enum of_overlay_notify_action for details.
>  Note that a notifier callback is not supposed to store pointers to a device
>  tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
>  respective node it received.
> -
> -Overlay DTS Format
> -------------------
> -
> -The DTS of an overlay should have the following format:
> -
> -{
> -	/* ignored properties by the overlay */
> -
> -	fragment@0 {	/* first child node */
> -
> -		target=<phandle>;	/* phandle target of the overlay */
> -	or
> -		target-path="/path";	/* target path of the overlay */
> -
> -		__overlay__ {
> -			property-a;	/* add property-a to the target */
> -			node-a {	/* add to an existing, or create a node-a */
> -				...
> -			};
> -		};
> -	}
> -	fragment@1 {	/* second child node */
> -		...
> -	};
> -	/* more fragments follow */
> -}
> -
> -Using the non-phandle based target method allows one to use a base DT which does
> -not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
> -The __symbols__ node is only required for the target=<phandle> method, since it
> -contains the information required to map from a phandle to a tree location.
> 

