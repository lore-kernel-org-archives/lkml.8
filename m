Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0613206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUzG/7jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFCBmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:42:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726894AbgFCBmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591148530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEshYeSWelwgVJ5AdPMme+4pdOtWR0iXHoli6kpArlg=;
        b=eUzG/7jqhtE6kXMTOEbFdkoG2UD2isqC3SoFvQhGWU0dek8HX/92Cpre4ZpVf4m+JEYT3J
        iIi2Az+A+Xx5ERExSzAJEFZ3kTfwPajWWpCc2z0nx+8qYMqVKFHHDOGffXZXXGBYOzhSJw
        RP+xzJmMUtPJCgLpT6pPZnBZQV5q25Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-qbRq1DVQNhal30UwB1vFZg-1; Tue, 02 Jun 2020 21:42:08 -0400
X-MC-Unique: qbRq1DVQNhal30UwB1vFZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A8CA80058E;
        Wed,  3 Jun 2020 01:42:07 +0000 (UTC)
Received: from localhost (unknown [10.10.110.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8069F5C240;
        Wed,  3 Jun 2020 01:42:04 +0000 (UTC)
Date:   Tue, 02 Jun 2020 18:42:03 -0700 (PDT)
Message-Id: <20200602.184203.261894695720513185.davem@redhat.com>
To:     anupam.al@samsung.com
Cc:     a.sahrawat@samsung.com, t.vivek@samsung.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: remove unused header file nfs_fs.h
From:   David Miller <davem@redhat.com>
In-Reply-To: <1590755160-26009-1-git-send-email-anupam.al@samsung.com>
References: <CGME20200529122614epcas5p38e0acf63c010f8b691caf68916f512bd@epcas5p3.samsung.com>
        <1590755160-26009-1-git-send-email-anupam.al@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anupam Aggarwal <anupam.al@samsung.com>
Date: Fri, 29 May 2020 17:56:00 +0530

> Remove unused header file linux/nfs_fs.h
> 
> Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
> Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>

Applied, thank you.

