Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4AC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B6A20679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PppgEIgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDUXhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:37:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52016 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDUXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:37:54 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AECE5528;
        Wed, 22 Apr 2020 01:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587512272;
        bh=5eFRCFCW+AQcwwQ1P4SI+kh5BzixH1YnCepykGCRdug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PppgEIgL2oA76DRoFXBlbUfuUsgkWw067Ew75aocw0CHqCyiSrwDAsI7zdvu2X8kj
         2dU4CUFHSL9p+0TZpFkbEl7vuOKiZaOOWXm6oexUDSR4j73WyKMsTPG/roimCx68dh
         tacN2Ywp59unw9IWwtRkdXHHlZ0fhpEsuyzK2UO0=
Date:   Wed, 22 Apr 2020 02:37:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Fix command line length limit calling
 dt-mk-schema
Message-ID: <20200421233737.GH5983@pendragon.ideasonboard.com>
References: <20200421212004.6146-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421212004.6146-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Tue, Apr 21, 2020 at 04:20:03PM -0500, Rob Herring wrote:
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
> Fix this by putting the schema file list into a temp file and using xargs.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Quite a bit slower than v5.6 when passing DT_SCHEMA_FILES, but
reasonable, and working now :-)

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/.gitignore | 2 +-
>  Documentation/devicetree/bindings/Makefile   | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
> index 5c6d8ea1a09c..0a6aef915fa4 100644
> --- a/Documentation/devicetree/bindings/.gitignore
> +++ b/Documentation/devicetree/bindings/.gitignore
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  *.example.dts
> -processed-schema*.yaml
> +processed-schema*.yaml*
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1df680d07461..1c1cad860b7c 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -14,7 +14,8 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
>  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
>  
>  quiet_cmd_mk_schema = SCHEMA  $@
> -      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
> +      cmd_mk_schema = $(file >$@.tmp, $(real-prereqs)) \
> +                      cat $@.tmp | xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@
>  
>  DT_DOCS = $(addprefix $(src)/, \
>  	$(shell \

-- 
Regards,

Laurent Pinchart
