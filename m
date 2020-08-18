Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24E3205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwjyIUoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHRK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:56:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726588AbgHRK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597748170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpL2InzPOSY+bQye+qdcClD9XKYCEvbdiWiHNpwsbPE=;
        b=PwjyIUoyVIHPgeCfr57jMWE4K6DQcxLPtPSBy64TuZjbkxvLlctOrgLx+jAIRzPuSr1ZFi
        soyNCgcoPeuXf0rRMoiy4hZhkq6aJ90kfufm3mWNJQJy16cc/ymug0A+Qt1T5Y9fYIUvU4
        ghfbRyaNLCSm9PfdF02JgqFi3Z/tT1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-fBHkZSE1MzyT-5PAVYzBCg-1; Tue, 18 Aug 2020 06:56:09 -0400
X-MC-Unique: fBHkZSE1MzyT-5PAVYzBCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14B0B425CC;
        Tue, 18 Aug 2020 10:56:08 +0000 (UTC)
Received: from krava (unknown [10.40.193.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 94DD95C69A;
        Tue, 18 Aug 2020 10:56:03 +0000 (UTC)
Date:   Tue, 18 Aug 2020 12:56:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, sdf@google.com,
        andriin@fb.com
Subject: Re: Kernel build error on BTFIDS vmlinux
Message-ID: <20200818105602.GC177896@krava>
References: <20200818105555.51fc6d62@carbon>
 <20200818091404.GB177896@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818091404.GB177896@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:14:10AM +0200, Jiri Olsa wrote:
> On Tue, Aug 18, 2020 at 10:55:55AM +0200, Jesper Dangaard Brouer wrote:
> > 
> > On latest DaveM net-git tree (06a4ec1d9dc652), after linking (LD vmlinux) the
> > "BTFIDS vmlinux" fails. Are anybody else experiencing this? Are there already a
> > fix? (just returned from vacation so not fully up-to-date on ML yet)
> > 
> > The tool which is called and error message:
> >   ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> >   FAILED elf_update(WRITE): invalid section alignment
> 
> hi,
> could you send your .config as well?

reproduced.. checking on fix

thanks,
jirka

