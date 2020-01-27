Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D94C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6C7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1KORNQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgA0L7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:59:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728981AbgA0L7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580126359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wGUqh+nM4OxUpTrPYCq32A4UC+1jAnUcmPHTtbJ+6U=;
        b=C1KORNQxe7BvgYE4MCNr1fjTlIIjedt9T+9k1RTo5Bbrmf66qAKveDBMAwURWBcFeZ7SEY
        Gp/wcQ+Y0xRAOkLXsTiechg1FCpOlV19kWuqSx8SEcciMYYjj14Eb63sIdw+AUuFO8KuDE
        Pd3lhdSdO7bpUMDj4kEGv4/XWtT0/dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-CL6sRUHwOzKRFhkMvSx7mg-1; Mon, 27 Jan 2020 06:59:17 -0500
X-MC-Unique: CL6sRUHwOzKRFhkMvSx7mg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5139B800EBB;
        Mon, 27 Jan 2020 11:59:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD1B7863BE;
        Mon, 27 Jan 2020 11:59:13 +0000 (UTC)
Date:   Mon, 27 Jan 2020 12:59:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] perf annotate: Simplify disasm_line allocation
 and freeing code
Message-ID: <20200127115911.GB1114818@krava>
References: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
 <20200124080432.8065-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124080432.8065-3-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:34:28PM +0530, Ravi Bangoria wrote:

SNIP

>  
>  /*
>   * Allocating the disasm annotation line data with
>   * following structure:
>   *
> - *    ------------------------------------------------------------
> - *    privsize space | struct disasm_line | struct annotation_line
> - *    ------------------------------------------------------------
> + *    -------------------------------------------
> + *    struct disasm_line | struct annotation_line
> + *    -------------------------------------------
>   *
>   * We have 'struct annotation_line' member as last member
>   * of 'struct disasm_line' to have an easy access.
> - *
>   */
>  static struct disasm_line *disasm_line__new(struct annotate_args *args)
>  {
>  	struct disasm_line *dl = NULL;
> -	struct annotation_line *al;
> -	size_t privsize = args->privsize + offsetof(struct disasm_line, al);
> +	int nr = 1;
>  
> -	al = annotation_line__new(args, privsize);

ok, I finally recalled why we did it like this.. for the python
annotation support, which never made it in ;-) however the allocation
in 'specialized' line and later call to annotation_line__init might
actualy be a better way

> -	if (al != NULL) {
> -		dl = disasm_line(al);
> +	if (perf_evsel__is_group_event(args->evsel))
> +		nr = args->evsel->core.nr_members;
>  
> -		if (dl->al.line == NULL)
> -			goto out_delete;
> +	dl = zalloc(disasm_line_size(nr));
> +	if (!dl)
> +		return NULL;
>  
> -		if (args->offset != -1) {
> -			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
> -				goto out_free_line;
> +	annotation_line__init(&dl->al, args, nr);
> +	if (dl->al.line == NULL)
> +		goto out_delete;
>  
> -			disasm_line__init_ins(dl, args->arch, &args->ms);
> -		}
> +	if (args->offset != -1) {
> +		if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
> +			goto out_free_line;
> +
> +		disasm_line__init_ins(dl, args->arch, &args->ms);
>  	}
>  
>  	return dl;
> @@ -1248,7 +1219,9 @@ void disasm_line__free(struct disasm_line *dl)
>  	else
>  		ins__delete(&dl->ops);
>  	zfree(&dl->ins.name);
> -	annotation_line__delete(&dl->al);
> +	free_srcline(dl->al.path);
> +	zfree(&dl->al.line);

no need to zfree if you're freeing the memory on the next line
also could you please put it to annotation_line__exit, since
you already added the __init function

> +	free(dl);
>  }
>  

the rest of the patches look good to me

thanks,
jirka

