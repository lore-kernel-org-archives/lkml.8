Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF63C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0340D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5PPwzoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFARsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:48:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgFARsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591033714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHDZa/gnknOU+QwJD6Q3MRS25PCoxq8rD1ldjgPu8Mk=;
        b=h5PPwzohGuei88RG2nINbMzkTQL1ZeyB4zGB5HISFBYLaUr8mYKk5LA+lPbLmlJcPC9XqF
        gvAgsoQhb4289uJ1b2LiHAgOBkYwLNurG0I1/GUUGO+0PhuBz0b3K5ifYne/ZGLe4w4ezA
        xx7+T99+Ke/fl/vIAhJyrbwE1U1aHBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-VKfnUjUpPGKSV1YTO6qB6Q-1; Mon, 01 Jun 2020 13:48:31 -0400
X-MC-Unique: VKfnUjUpPGKSV1YTO6qB6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65CC2801504;
        Mon,  1 Jun 2020 17:48:29 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A95D19D7C;
        Mon,  1 Jun 2020 17:48:26 +0000 (UTC)
Date:   Mon, 1 Jun 2020 19:48:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?iso-8859-1?Q?R=E9mi?= Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [RFC PATCH 1/2] perf dso: Use libbfd to read build_id and
 .gnu_debuglink section
Message-ID: <20200601174826.GG1031432@krava>
References: <20200601111915.114974-1-rbernon@codeweavers.com>
 <20200601111915.114974-2-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601111915.114974-2-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 01:19:14PM +0200, Rémi Bernon wrote:

SNIP

>  int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
> @@ -611,6 +638,37 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
>  int filename__read_debuglink(const char *filename, char *debuglink,
>  			     size_t size)
>  {
> +#ifdef HAVE_LIBBFD_SUPPORT
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
> +#else

please define 2 filename__read_debuglink functions
for each ifdef leg

thanks,
jirka

>  	int fd, err = -1;
>  	Elf *elf;
>  	GElf_Ehdr ehdr;
> @@ -658,6 +716,7 @@ int filename__read_debuglink(const char *filename, char *debuglink,
>  	close(fd);
>  out:
>  	return err;
> +#endif
>  }
>  
>  static int dso__swap_init(struct dso *dso, unsigned char eidata)
> -- 
> 2.26.1
> 

