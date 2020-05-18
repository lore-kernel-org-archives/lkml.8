Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C58CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60822065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbERVnpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEROzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:55:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbgEROzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589813735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yAldgoyB3mAzWkQsju8c9s+EKf3cYLO77s6Z8Cfh+k=;
        b=XbERVnpP9daDhTxIbiapWnw/nxvMBUc7S4fdxlm94pSXUY8wWywNaMeTVIDPHVBpKqgj/7
        eljeTVdZlzGZoVYbTndRNPg0mUDn9Rs7TH6b2Pgz9pCHaWRkFR0ZciLD4PrHu8GqeIUKAv
        7gisAhG2rCjm1XdDQiBJZZ8LKA6wAsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-OQV_8YZ0Ow-v2Gx-1u1iwQ-1; Mon, 18 May 2020 10:55:34 -0400
X-MC-Unique: OQV_8YZ0Ow-v2Gx-1u1iwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07968800D24;
        Mon, 18 May 2020 14:55:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9201944E;
        Mon, 18 May 2020 14:55:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <367178.1589627756@turing-police>
References: <367178.1589627756@turing-police>
To:     =?us-ascii?Q?Valdis_=3D=3Futf-8=3FQ=3FKl=3Dc4=3D93tnieks=3F=3D?= 
        <valdis.kletnieks@vt.edu>
Cc:     dhowells@redhat.com, Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watch_queue: sample: Update makefile to fix deprecated variables
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 18 May 2020 15:55:30 +0100
Message-ID: <919012.1589813730@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> wrote:

> A recent commit started warning for deprecated makefile variables.
> Turns out there was an in-tree user, so update it.
>=20
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

I've folded this in, thanks.

David

