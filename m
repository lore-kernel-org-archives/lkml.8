Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC11C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615FC20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDmdPCPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBCNa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:30:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbgBCNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580736628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdAsb+jbEHtf+vbvPttlmGBhB3W4rDZHLkASCl6Lfck=;
        b=RDmdPCPlltv7Mi+8khngV5MeMiGOgnviqpmVxwI8qirn+TPt2NT6Kso1B3qXavCY/4XW6f
        WECPwsLSiPtC2iFNzqX1nIsgFZGtQA43L4dbMqQDQHlTvvCfre/HOoMcV3M5UqXNQWchI4
        XtghQ/o+Po3wXnME/jg9LK0hjCkKpIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-JI1k5S-JPaug1D6lqRFPWA-1; Mon, 03 Feb 2020 08:30:21 -0500
X-MC-Unique: JI1k5S-JPaug1D6lqRFPWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9983213F8;
        Mon,  3 Feb 2020 13:30:19 +0000 (UTC)
Received: from krava (ovpn-204-137.brq.redhat.com [10.40.204.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2688B8E9E5;
        Mon,  3 Feb 2020 13:30:16 +0000 (UTC)
Date:   Mon, 3 Feb 2020 14:30:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] perf annotate: Remove privsize from
 symbol__annotate() args
Message-ID: <20200203133004.GA1521029@krava>
References: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
 <20200124080432.8065-2-ravi.bangoria@linux.ibm.com>
 <20200130111653.GE3841@kernel.org>
 <ab9edd7d-04d1-f988-9f29-81d65a807250@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9edd7d-04d1-f988-9f29-81d65a807250@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:24:29AM +0530, Ravi Bangoria wrote:
> 
> 
> On 1/30/20 4:46 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 24, 2020 at 01:34:27PM +0530, Ravi Bangoria escreveu:
> > > privsize is passed as 0 from all the symbol__annotate() callers.
> > > Remove it from argument list.
> > 
> > Right, trying to figure out when was it that this became unnecessary to
> > see if this in fact is hiding some other problem...
> > 
> > It all starts in the following change, re-reading those patches...
> > 
> > - Arnaldo
> > 
> 
> Ok, I just had a quick look at:
> https://lore.kernel.org/lkml/20171011194323.GI3503@kernel.org/
> 
> This change was for python annotation support which, I guess, Jiri didn't posted
> the patches? Jiri, are you planning to post them?

yea, as I wrote in another reply, this came in as preparation
to support python code lines, which still did not get in ;-)

also I replied that this way is probably even better for that,
so that's why I'm ok with the change

jirka

