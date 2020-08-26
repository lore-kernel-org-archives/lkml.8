Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E0DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20412087C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Isc17wQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgHZLre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:47:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49298 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728933AbgHZLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598442442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=owZflYvt8RopEJffCSctLRqiuBqMsYk/WFfZTFUGzek=;
        b=Isc17wQJ0aO8lUcJJxbfC9/TfDnSPyx220facS71TNJGdCylhJJ9DhzMblfO26hhs3gfRF
        1e9rGORLSz8xnytWVtuqcnHkxE4zLOCQNheCiPMWKkh+qlS0jF/hfwFPe4XzqFeYdFuXn4
        zp372vHcowHetiq3BFn6EqiY/BOilCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-7znGlChsMXybvdmZHQr8kg-1; Wed, 26 Aug 2020 07:47:20 -0400
X-MC-Unique: 7znGlChsMXybvdmZHQr8kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C22768030B4;
        Wed, 26 Aug 2020 11:47:18 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A9696F142;
        Wed, 26 Aug 2020 11:47:15 +0000 (UTC)
Date:   Wed, 26 Aug 2020 13:47:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH v3 1/3] perf dso: Use libbfd to read build_id and
 .gnu_debuglink section
Message-ID: <20200826114713.GD753783@krava>
References: <20200821165238.1340315-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821165238.1340315-1-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:36PM +0200, Remi Bernon wrote:
> Wine generates PE binaries for most of its modules and perf is unable
> to parse these files to get build_id or .gnu_debuglink section.
> 
> Using libbfd when available, instead of libelf, makes it possible to
> resolve debug file location regardless of the dso binary format.
> 
> Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jacek Caban <jacek@codeweavers.com>
> ---
> 
> v3: Rebase and small changes to PATCH 2/3 and and PATCH 3/3.

all 3 patches look ok to me especially since I found out the new
code for loading symbols is for non ELF objects only ;-)

it'd be great if somebody with libbfd skills could review this,
but for me it looks ok.. for patchset:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/util/symbol-elf.c | 80 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 8cc4b0059fb0..f7432c4a4154 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -50,6 +50,10 @@ typedef Elf64_Nhdr GElf_Nhdr;
>  #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
>  #endif
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +#define PACKAGE 'perf'
> +#include <bfd.h>
> +#else
>  #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
>  extern char *cplus_demangle(const char *, int);
>  
> @@ -65,9 +69,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
>  {
>  	return NULL;
>  }
> -#else
> -#define PACKAGE 'perf'
> -#include <bfd.h>
> +#endif
>  #endif
>  #endif
>  
> @@ -530,6 +532,36 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>  	return err;
>  }
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +
> +int filename__read_build_id(const char *filename, void *bf, size_t size)
> +{
> +	int err = -1;
> +	bfd *abfd;
> +
> +	abfd = bfd_openr(filename, NULL);
> +	if (!abfd)
> +		return -1;
> +
> +	if (!bfd_check_format(abfd, bfd_object)) {
> +		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
> +		goto out_close;
> +	}
> +
> +	if (!abfd->build_id || abfd->build_id->size > size)
> +		goto out_close;
> +
> +	memcpy(bf, abfd->build_id->data, abfd->build_id->size);
> +	memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
> +	err = abfd->build_id->size;
> +
> +out_close:
> +	bfd_close(abfd);
> +	return err;
> +}
> +
> +#else
> +
>  int filename__read_build_id(const char *filename, void *bf, size_t size)
>  {
>  	int fd, err = -1;
> @@ -557,6 +589,8 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>  	return err;
>  }
>  
> +#endif
> +
>  int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
>  {
>  	int fd, err = -1;
> @@ -608,6 +642,44 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
>  	return err;
>  }
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +
> +int filename__read_debuglink(const char *filename, char *debuglink,
> +			     size_t size)
> +{
> +	int err = -1;
> +	asection *section;
> +	bfd *abfd;
> +
> +	abfd = bfd_openr(filename, NULL);
> +	if (!abfd)
> +		return -1;
> +
> +	if (!bfd_check_format(abfd, bfd_object)) {
> +		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
> +		goto out_close;
> +	}
> +
> +	section = bfd_get_section_by_name(abfd, ".gnu_debuglink");
> +	if (!section)
> +		goto out_close;
> +
> +	if (section->size > size)
> +		goto out_close;
> +
> +	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
> +				      section->size))
> +		goto out_close;
> +
> +	err = 0;
> +
> +out_close:
> +	bfd_close(abfd);
> +	return err;
> +}
> +
> +#else
> +
>  int filename__read_debuglink(const char *filename, char *debuglink,
>  			     size_t size)
>  {
> @@ -660,6 +732,8 @@ int filename__read_debuglink(const char *filename, char *debuglink,
>  	return err;
>  }
>  
> +#endif
> +
>  static int dso__swap_init(struct dso *dso, unsigned char eidata)
>  {
>  	static unsigned int const endian = 1;
> -- 
> 2.28.0
> 

