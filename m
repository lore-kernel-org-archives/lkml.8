Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A436BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BA521741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BO0m/tJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHZO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:26:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56541 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727063AbgHZO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598452001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8VHPX0SSz8RwyuzQquZJo1iP+N4BLxDKj3ZvV5GLd14=;
        b=BO0m/tJp5ge3iX10XMxGmiecZOqHXNilqz798HqeIOnFqdoJCmyw5If1poKYTT/Y5VrtHY
        rP785smMNftsCHwhWMoVatWZlzlhjYJc6fc9wyOQg8uDGHL49F+z5coLJW0HzdTL/Wq6Ri
        EUu1pR+aB10wD3YSefQWAY+EBASPfQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-wCdJOSjFNHmm7btMpGEHQA-1; Wed, 26 Aug 2020 10:26:36 -0400
X-MC-Unique: wCdJOSjFNHmm7btMpGEHQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 928FD8030A8;
        Wed, 26 Aug 2020 14:26:35 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CFA510021AA;
        Wed, 26 Aug 2020 14:26:35 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id C9729203; Wed, 26 Aug 2020 11:26:31 -0300 (BRT)
Date:   Wed, 26 Aug 2020 11:26:31 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Al Grant <al.grant@foss.arm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200826142631.GA5351@redhat.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825174043.GQ1509399@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
> On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> > perf_event.h has macros that define the field offsets in the
> > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > were both 37. These are distinct fields, and the bitfield layout
> > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> 
> Looks good.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Probably should have a Fixes: header

Please do so, find the patch that introduced the error, add the Fixes
tag, will help me not having to do it myself :-)

- Arnaldo

