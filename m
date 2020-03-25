Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9255C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC3020775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWEeOHan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCYJ7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:59:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58040 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCYJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585130384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E28MMaAg2Rq74B9GHLdMLCeDNE/kzIHBch46RLtapL0=;
        b=OWEeOHanKpU2ePpAwngQGB3ZLBZf7ZnaQuh69M35esy5QuzSKD/8mP1qnd7vjXhENS8r3I
        B+74kCKoC30yGDUt55zvqKthuuIDXimT7uJDEDHHLaa9M3CgQUB5HRgTL6iv4qMAyaSWoY
        RBQlFSVJFU1oBX/xKvXhssngC+7a58k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-UkxxZoVqOlmQW2B8TIESxA-1; Wed, 25 Mar 2020 05:59:41 -0400
X-MC-Unique: UkxxZoVqOlmQW2B8TIESxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C4C0189D6C3;
        Wed, 25 Mar 2020 09:59:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0BF25C28E;
        Wed, 25 Mar 2020 09:59:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1339A17535; Wed, 25 Mar 2020 10:59:38 +0100 (CET)
Date:   Wed, 25 Mar 2020 10:59:38 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Juerg Haefliger <juergh@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: arm64 kernel crash in bochs_get_edid_block() with QEMU '-device
 VGA'
Message-ID: <20200325095938.vn4v7bdk6pgmotxg@sirius.home.kraxel.org>
References: <CADLDEKugE-Y9rMumiCDJDW_FvGcBaQd3fBv80YeSS0=udnkMAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADLDEKugE-Y9rMumiCDJDW_FvGcBaQd3fBv80YeSS0=udnkMAQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 01:11:45PM +0100, Juerg Haefliger wrote:
> The QEMU default edid=off results in a kernel crash [1] on arm64 due
> to commit [2]. To reproduce:

Should be fixed in qemu 5.0-rc0

cheers,
  Gerd

