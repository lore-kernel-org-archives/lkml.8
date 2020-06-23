Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62223C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6C20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1sDNJz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgFWPOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:14:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732781AbgFWPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592925291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YjBiafP2Gc/HxgD2ng3VQEJxywwce/cABRCluHTwfs=;
        b=d1sDNJz48SdfS0df51tTeumnEvv/QeTy4jEVIuFao74vwvGcjK1nKTsovndhkB6EdedBlC
        N5ejGn1VkjHVZjGePB6hDv94XtDiZTwKDxBKRGfnoFdJzikN/GbuBD37mPcPLs4iFUzRoP
        7V05LeZN21BZJTmHy8w+0B1w0L9v5uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-uomy0hkxOl-abiz1p8UwiQ-1; Tue, 23 Jun 2020 11:14:47 -0400
X-MC-Unique: uomy0hkxOl-abiz1p8UwiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 530391005512;
        Tue, 23 Jun 2020 15:14:46 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 42CB46EF8F;
        Tue, 23 Jun 2020 15:14:43 +0000 (UTC)
Date:   Tue, 23 Jun 2020 17:14:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/13] perf evlist: implement control command handling
 functions
Message-ID: <20200623151442.GL2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
 <20200623145601.GH2619137@krava>
 <20200623150345.GA26230@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623150345.GA26230@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:03:45PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 23, 2020 at 04:56:01PM +0200, Jiri Olsa escreveu:
> > On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> > > +	memset(cmd_data, 0, data_size--);
> > > +
> > > +	do {
> > > +		err = read(evlist->ctl_fd.fd, &c, 1);
> > > +		if (err > 0) {
> > > +			if (c == '\n' || c == '\0')
> > > +				break;
> > > +			cmd_data[bytes_read++] = c;
> > > +			if (bytes_read == data_size)
> > > +				break;
> > > +		} else {
> > > +			if (err == -1)
> > > +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
> > > +			break;
> > > +		}
> > > +	} while (1);
> > > +
> > > +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> > > +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> > > +
> > > +	if (err > 0) {
> > > +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> > > +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
> > 
> > you could use sizeof(EVLIST_CTL_CMD_ENABLE_TAG) instead, no function call
> 
> -1, as sizeof will get the \0, right?

yep, I think that's right

jirka

> 
> > 
> > > +			*cmd = EVLIST_CTL_CMD_ENABLE;
> > > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> > > +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
> > 
> > ditto
> > 
> > jirka
> > 
> 
> -- 
> 
> - Arnaldo
> 

