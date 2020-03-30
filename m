Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686942073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eh1sDu08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgC3Grq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:47:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48456 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728964AbgC3Grp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585550865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8efMudaMe4SXKlisr5XoKCgiji5DGX+MNsa2rB9kjG8=;
        b=eh1sDu08ajbQDobrXtOjcFATtYLb82UKNAf/sdn6oAmwwI4GiQr6BjBZlKM19FX7kWhi3q
        zBs8OmMkCesV1Su8nX6/oe45RqQJkVgAZqDPnaht14oCWdmEnwagJXafElW8R1RzqqIeRa
        tKcm5Obz9PsY6ALOhA8raB9bjZD4x20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-rQLyBsIWN9We9sa-h3OYhw-1; Mon, 30 Mar 2020 02:47:43 -0400
X-MC-Unique: rQLyBsIWN9We9sa-h3OYhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 034F7107ACC9;
        Mon, 30 Mar 2020 06:47:42 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F165DA76;
        Mon, 30 Mar 2020 06:47:39 +0000 (UTC)
Date:   Mon, 30 Mar 2020 08:47:34 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Simran Singhal <singhalsimran0@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: rtw_efuse:
 Compress lines for immediate return
Message-ID: <20200330084734.479420cd@elisabeth>
In-Reply-To: <20200325205418.GA29149@simran-Inspiron-5558>
References: <20200325205418.GA29149@simran-Inspiron-5558>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 02:24:18 +0530
Simran Singhal <singhalsimran0@gmail.com> wrote:

> Compress two lines into a single line if immediate return statement is found.

Same as your patches for issues reported by checkpatch, I think you
should post these ones as a patchset.

-- 
Stefano

