Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FEFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E38F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxoWMwra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgFPOTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:19:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbgFPOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592317174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1VDjVY8ljytaIU7oja+UH832lNJTSMuRA4Sv5hnPs8=;
        b=JxoWMwraSBTO7jzN7X2DPRBu8ECZzzghXf3FOfDg/GsL4AUdw2xab1xhyZY9k3epkvnAl9
        cibdTOC+NWPrhHgeyvzyOJZDhxGwBXgh/hHplloVFEQ4nnNusQKr+UeM5p7dw5yIDUnBOp
        2d1UleBkpLhCL+hneaMeavcX6AD28fM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-2lX4X5jUOo2Is9nT2aYKwA-1; Tue, 16 Jun 2020 10:19:27 -0400
X-MC-Unique: 2lX4X5jUOo2Is9nT2aYKwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB584100CCC8;
        Tue, 16 Jun 2020 14:19:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BACE19D61;
        Tue, 16 Jun 2020 14:19:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 Jun 2020 16:19:25 +0200 (CEST)
Date:   Tue, 16 Jun 2020 16:19:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] tracing/probe: fix memleak in fetch_op_data operations
Message-ID: <20200616141921.GA25691@redhat.com>
References: <20200615143034.GA1734@cosmos>
 <20200615171337.6525cefa@oasis.local.home>
 <20200616174647.d1985a66fa9bbcbe01e014b4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616174647.d1985a66fa9bbcbe01e014b4@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16, Masami Hiramatsu wrote:
>
> BTW, for uprobes, I think Oleg is mainly reviewed changes on that in
> these days. Maybe better to assign him?

Well, then I'd suggest both me and Srikar.

Oleg.

