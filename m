Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF82C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDE62166E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DY3WH2bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgDWQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729386AbgDWQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:06:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C2C09B040;
        Thu, 23 Apr 2020 09:06:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B5BE4F7;
        Thu, 23 Apr 2020 18:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587657996;
        bh=eWZUj9lTkWCXbhwqDd22bo5n7vvld9tAlLBaI/AKyv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DY3WH2bJ8iJqesFWYQRAgc8apuelXqtZ/iHRDw+zHNOQC7hM6JCLyNNTaM8gxEAK5
         WjAHJAVRNkG55Otg2RPBzSnARNva14Kd1mLtU9ZyfeAdafVYqx0qUjMxzB2kLcYy32
         MeQ2uqL7UOq1ADpod+3DO5CMqmXSit3XxqtPbuco=
Date:   Thu, 23 Apr 2020 19:06:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: Fix command line length limit calling
 dt-mk-schema
Message-ID: <20200423160622.GE6196@pendragon.ideasonboard.com>
References: <20200422185708.6363-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422185708.6363-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Wed, Apr 22, 2020 at 01:57:08PM -0500, Rob Herring wrote:
> As the number of schemas has increased, we're starting to hit the error
> "execvp: /bin/sh: Argument list too long". This is due to passing all the
> schema files on the command line to dt-mk-schema. It currently is only
> with out of tree builds and is intermittent depending on the file path
> lengths.
> 
> Commit 2ba06cd8565b ("kbuild: Always validate DT binding examples") made
> hitting this proplem more likely since the example validation now always
> gets the full list of schemas.
> 
> Fix this by passing the schema file list in a pipe and using xargs. We end
> up doing the find twice, but the time is insignificant compared to the
> dt-mk-schema time.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/Makefile | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 87c76bdabfe6..7782d9985082 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -14,16 +14,18 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
>  # Use full schemas when checking %.example.dts
>  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
>  
> +find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
> +		-name 'processed-schema*' ! \
> +		-name '*.example.dt.yaml' \)
> +
>  quiet_cmd_mk_schema = SCHEMA  $@
> -      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
> +      cmd_mk_schema = rm -f $@ ; \
> +                      $(if $(DT_MK_SCHEMA_FLAGS), \
> +                           echo $(real-prereqs), \
> +                           $(find_cmd)) | \
> +                      xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) >> $@
>  
> -DT_DOCS = $(addprefix $(src)/, \
> -	$(shell \
> -	cd $(srctree)/$(src) && \
> -	find * \( -name '*.yaml' ! \
> -		-name 'processed-schema*' ! \
> -		-name '*.example.dt.yaml' \) \
> -	))
> +DT_DOCS = $(shell $(find_cmd) | sed -e 's|^$(srctree)/||')
>  
>  DT_SCHEMA_FILES ?= $(DT_DOCS)
>  

-- 
Regards,

Laurent Pinchart
