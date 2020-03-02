Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC14C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C914522B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwg43iI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCBVSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:18:54 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41746 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:18:53 -0500
Received: by mail-yw1-f68.google.com with SMTP id h6so1255630ywc.8;
        Mon, 02 Mar 2020 13:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/KUu0opL3uZYvxQJsCy8Y8178zDhlh2aSw48uKAX3c=;
        b=Nwg43iI8OwuhftbSQssimzDODSkNTuC/tSni/vfexz+AC/5UbZ2Sur5bTZ54KQZ85e
         jU1sq01Zps12+Y9psvribPRxQwx0hrmL+Afs2N0QP276Iy10HS9PlT+bb5vJIjgWc/iy
         vz7l5J6cLhohk/F2bb6wij0DF+RB1hx1yEPTeh5fcGc4qT7Sl+eH+tFMrWn7LuvqrE8g
         KHqYAXpK8xfNdZxmGj/es0d/GWL5AoTDfd+fFI5kBjIfAzk6aex7jwgf3Gy2+5pw40DD
         mimkcpfG2W58bWcpjbtIlI0AHG5zhuyjZMW4ZClHPHvUKYPryM1HSGAZ3IbTCWd+VSEc
         dFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/KUu0opL3uZYvxQJsCy8Y8178zDhlh2aSw48uKAX3c=;
        b=Z6dnFESpNaz+bKZzbJcytZjDK/CYTZIFCJQfZ29lb+SsqHxJnlNqqXrnPyhMt4ex9u
         RKzdh0Fgk6UrogFDuc4zedmdo9Fz1KPYgKHh1bddhM/28ekLr8Vin6yGYtgZP+AcuJfw
         LXLlZEByykmT6RtIILTjsiWxjQStJEwzJfLDznGbeBoME1r6c3Tkf4y9HQhxdAQTFx5o
         VpesjC05/n1Q05UoX04e7ESFhomQEgIHyQpkloWsTCZrgk7F9neso6RZjzdsrz2GD699
         ApurMXRG/NZ7R2ofCX51knStCLNtay1GFdUYCnVc3OzmdMp+Q3PKxgUXTqoAoVYmr10D
         tqww==
X-Gm-Message-State: ANhLgQ2K0h3I/OpOQ1+e9W63E78TfOExbQNxBZYowNVVDWNPEVFZyvbX
        6ywpaRxMVGnocgIfOVYXEyE=
X-Google-Smtp-Source: ADFU+vuAUOl95lgMt5QEI/Y28FG9m8/Pm0UZgjvDEo9NZYdIcMyvN1YHAOy4x3uTbpiBxtxYs7/yGA==
X-Received: by 2002:a25:5f51:: with SMTP id h17mr999632ybm.210.1583183931919;
        Mon, 02 Mar 2020 13:18:51 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d188sm8094748ywd.24.2020.03.02.13.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:18:51 -0800 (PST)
Subject: Re: [PATCH v2 02/12] docs: dt: convert usage-model.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
 <0432bc8cdb6abb8618eac89d68db7441b613106d.1583135507.git.mchehab+huawei@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <33664e07-c3e4-12fa-9cbe-a3225bb6f343@gmail.com>
Date:   Mon, 2 Mar 2020 15:18:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0432bc8cdb6abb8618eac89d68db7441b613106d.1583135507.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Use footnoote markups;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to devicetree/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/index.rst            |  1 +
>  Documentation/devicetree/of_unittest.txt      |  2 +-
>  .../{usage-model.txt => usage-model.rst}      | 35 +++++++++++--------
>  include/linux/mfd/core.h                      |  2 +-
>  4 files changed, 23 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)
> 
> diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> index a11efe26f205..7a6aad7d384a 100644
> --- a/Documentation/devicetree/index.rst
> +++ b/Documentation/devicetree/index.rst
> @@ -7,4 +7,5 @@ Open Firmware and Device Tree
>  .. toctree::
>     :maxdepth: 1
>  
> +   usage-model
>     writing-schema
> diff --git a/Documentation/devicetree/of_unittest.txt b/Documentation/devicetree/of_unittest.txt
> index 3e4e7d48ae93..9fdd2de9b770 100644
> --- a/Documentation/devicetree/of_unittest.txt
> +++ b/Documentation/devicetree/of_unittest.txt
> @@ -11,7 +11,7 @@ architecture.
>  
>  It is recommended to read the following documents before moving ahead.
>  
> -[1] Documentation/devicetree/usage-model.txt
> +[1] Documentation/devicetree/usage-model.rst
>  [2] http://www.devicetree.org/Device_Tree_Usage
>  
>  OF Selftest has been designed to test the interface (include/linux/of.h)
> diff --git a/Documentation/devicetree/usage-model.txt b/Documentation/devicetree/usage-model.rst
> similarity index 97%
> rename from Documentation/devicetree/usage-model.txt
> rename to Documentation/devicetree/usage-model.rst
> index 33a8aaac02a8..326d7af10c5b 100644
> --- a/Documentation/devicetree/usage-model.txt
> +++ b/Documentation/devicetree/usage-model.rst
> @@ -1,14 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
>  Linux and the Device Tree
> --------------------------
> +=========================
> +
>  The Linux usage model for device tree data
>  
> -Author: Grant Likely <grant.likely@secretlab.ca>
> +:Author: Grant Likely <grant.likely@secretlab.ca>
>  
>  This article describes how Linux uses the device tree.  An overview of
>  the device tree data format can be found on the device tree usage page
> -at devicetree.org[1].
> +at devicetree.org\ [1]_.
>  
> -[1] http://devicetree.org/Device_Tree_Usage
> +.. [1] http://devicetree.org/Device_Tree_Usage

I don't know the proper ReST syntax for footnotes, but on the html page
you kindly provided in 00/12, '.. [1]' is shown as '1(1,2)'.

-Frank


>  
>  The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
>  structure and language for describing hardware.  More specifically, it
> @@ -57,7 +61,7 @@ Tree (FDT) was created which could be passed to the kernel as a binary
>  blob without requiring a real Open Firmware implementation.  U-Boot,
>  kexec, and other bootloaders were modified to support both passing a
>  Device Tree Binary (dtb) and to modify a dtb at boot time.  DT was
> -also added to the PowerPC boot wrapper (arch/powerpc/boot/*) so that
> +also added to the PowerPC boot wrapper (``arch/powerpc/boot/*``) so that
>  a dtb could be wrapped up with the kernel image to support booting
>  existing non-DT aware firmware.
>  
> @@ -68,7 +72,7 @@ out of mainline (nios) have some level of DT support.
>  
>  2. Data Model
>  -------------
> -If you haven't already read the Device Tree Usage[1] page,
> +If you haven't already read the Device Tree Usage\ [1]_ page,
>  then go read it now.  It's okay, I'll wait....
>  
>  2.1 High Level View
> @@ -88,6 +92,7 @@ duplication and make it easier to support a wide range of hardware
>  with a single kernel image.
>  
>  Linux uses DT data for three major purposes:
> +
>  1) platform identification,
>  2) runtime configuration, and
>  3) device population.
> @@ -117,7 +122,7 @@ The 'compatible' property contains a sorted list of strings starting
>  with the exact name of the machine, followed by an optional list of
>  boards it is compatible with sorted from most compatible to least.  For
>  example, the root compatible properties for the TI BeagleBoard and its
> -successor, the BeagleBoard xM board might look like, respectively:
> +successor, the BeagleBoard xM board might look like, respectively::
>  
>  	compatible = "ti,omap3-beagleboard", "ti,omap3450", "ti,omap3";
>  	compatible = "ti,omap3-beagleboard-xm", "ti,omap3450", "ti,omap3";
> @@ -183,7 +188,7 @@ configuration data like the kernel parameters string and the location
>  of an initrd image.
>  
>  Most of this data is contained in the /chosen node, and when booting
> -Linux it will look something like this:
> +Linux it will look something like this::
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200 loglevel=8";
> @@ -251,9 +256,9 @@ platform devices roughly correspond to device nodes at the root of the
>  tree and children of simple memory mapped bus nodes.
>  
>  About now is a good time to lay out an example.  Here is part of the
> -device tree for the NVIDIA Tegra board.
> +device tree for the NVIDIA Tegra board::
>  
> -/{
> +  /{
>  	compatible = "nvidia,harmony", "nvidia,tegra20";
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> @@ -313,7 +318,7 @@ device tree for the NVIDIA Tegra board.
>  		i2s-controller = <&i2s1>;
>  		i2s-codec = <&wm8903>;
>  	};
> -};
> +  };
>  
>  At .init_machine() time, Tegra board support code will need to look at
>  this DT and decide which nodes to create platform_devices for.
> @@ -379,13 +384,13 @@ device tree support code reflects that and makes the above example
>  simpler.  The second argument to of_platform_populate() is an
>  of_device_id table, and any node that matches an entry in that table
>  will also get its child nodes registered.  In the Tegra case, the code
> -can look something like this:
> +can look something like this::
>  
> -static void __init harmony_init_machine(void)
> -{
> +  static void __init harmony_init_machine(void)
> +  {
>  	/* ... */
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> +  }
>  
>  "simple-bus" is defined in the Devicetree Specification as a property
>  meaning a simple memory mapped bus, so the of_platform_populate() code
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index d01d1299e49d..21718c8b2b48 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -74,7 +74,7 @@ struct mfd_cell {
>  
>  	/*
>  	 * Device Tree compatible string
> -	 * See: Documentation/devicetree/usage-model.txt Chapter 2.2 for details
> +	 * See: Documentation/devicetree/usage-model.rst Chapter 2.2 for details
>  	 */
>  	const char		*of_compatible;
>  
> 

