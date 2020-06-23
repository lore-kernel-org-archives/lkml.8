Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F338E20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592924630;
	bh=soLk9tHcyZMj32YGp0QZQRF8FQvz57n5ghu4cncgjPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sL6NoVoBMP8/kCPPKVPntZWj7JwJIGEp40J0MeDnlaJefmuFoZGeSw+Fq7iPWVpa+
	 55WoCQN+cgBdKphR/vS+Yj14RL87Ql/omfQdbM9Gpbj14FSbwUJGIkkHL4rOUv5GH2
	 KFx4s3eJ35STHldNZwf3W8OhGs0XwYEQcYY1kHs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbgFWPDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732862AbgFWPDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:03:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288B120723;
        Tue, 23 Jun 2020 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592924628;
        bh=soLk9tHcyZMj32YGp0QZQRF8FQvz57n5ghu4cncgjPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThcJxpJHtMwx4ohRDXwXRlZjEiawns/3J+Frb7elkq760zVZ+T1l+IpRWyq6xcVhA
         GIsW/DAlOiki/tv17A5I7SYmAracDuGSJSbJ7DYx3ySRNhmeghbK0Os4r+h7RwGt23
         kJkbPgcAXIXF3UwYz23fY/V5thCpvI+99agWnDoA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6497C405FF; Tue, 23 Jun 2020 12:03:45 -0300 (-03)
Date:   Tue, 23 Jun 2020 12:03:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/13] perf evlist: implement control command handling
 functions
Message-ID: <20200623150345.GA26230@kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
 <20200623145601.GH2619137@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623145601.GH2619137@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 23, 2020 at 04:56:01PM +0200, Jiri Olsa escreveu:
> On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
> > +	memset(cmd_data, 0, data_size--);
> > +
> > +	do {
> > +		err = read(evlist->ctl_fd.fd, &c, 1);
> > +		if (err > 0) {
> > +			if (c == '\n' || c == '\0')
> > +				break;
> > +			cmd_data[bytes_read++] = c;
> > +			if (bytes_read == data_size)
> > +				break;
> > +		} else {
> > +			if (err == -1)
> > +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
> > +			break;
> > +		}
> > +	} while (1);
> > +
> > +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> > +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> > +
> > +	if (err > 0) {
> > +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> > +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
> 
> you could use sizeof(EVLIST_CTL_CMD_ENABLE_TAG) instead, no function call

-1, as sizeof will get the \0, right?

> 
> > +			*cmd = EVLIST_CTL_CMD_ENABLE;
> > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> > +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
> 
> ditto
> 
> jirka
> 

-- 

- Arnaldo
