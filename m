Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B697CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5702067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXSg1ywy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgFBP54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:57:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgFBP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591113475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASapiG1/TIS7H1SxUqbkFSMoaWA/OIJ5pQnMhbATzrQ=;
        b=iXSg1ywyREwAwsDxRnPReXTwIr9S/hecv1SJM3VG/MGi3sFvYWqsZ9DBRFxqQGEFwa5gym
        AKM19/xL+MAcWQ+GOEYTxqQYANzpcIJTOTlrmm187yIBSXsT/p4NMB1o9ao+oZlszLjR7D
        QFnmDCo9OHWO59IHU2YP34Aj5OeK38g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-ktdmV6otPgG0CWWrUc8lSQ-1; Tue, 02 Jun 2020 11:57:42 -0400
X-MC-Unique: ktdmV6otPgG0CWWrUc8lSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14C4107B0EF;
        Tue,  2 Jun 2020 15:57:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE51A1BCBE;
        Tue,  2 Jun 2020 15:57:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200602153505.64714-1-colin.king@canonical.com>
References: <20200602153505.64714-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] afs: fix double kfree on cell_name on error exit path
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1504659.1591113454.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Jun 2020 16:57:34 +0100
Message-ID: <1504660.1591113454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> =

> The error exit path is currently kfree'ing cell_name for a second time,
> the previous kfree of this object occurred a statement earlier. Fix this
> by removing it.
> =

> Addresses-Coverity: ("Double free")
> Fixes: 6147fe6b7f8c ("afs: Detect cell aliases 3 - YFS Cells with a cano=
nical cell name op")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I've folded it in, thanks.

David

