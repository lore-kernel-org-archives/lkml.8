Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42471C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FDC206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dm+jWpFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgCOQZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:25:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728718AbgCOQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584289536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pe0Gcv52CVpbmkulDoJTTWqlpmRC39S89meMMW/oGFw=;
        b=dm+jWpFTNQ34/JiYrE8/hVktRSs6OHyQ5OBws1FC/CwOSs7ZdLUSiBqr7xvkb9r4VeOU0P
        cezJ/OsBhipTmboAOMl1pH4MtNXUb8SQDVEViapXE2TidmFnlhJizACreaZZVoooZ0XcrR
        VI12nkw/M/04fJd/i8Wey42uwAR2V6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-0iMGEpF5NcKWhwkBHCcHEA-1; Sun, 15 Mar 2020 12:25:33 -0400
X-MC-Unique: 0iMGEpF5NcKWhwkBHCcHEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693BA184D294;
        Sun, 15 Mar 2020 16:25:32 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A0FA1001B2B;
        Sun, 15 Mar 2020 16:25:30 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:25:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 08/16] Optimize find_section_by_name()
Message-ID: <20200315162528.3d6glgnpkkygmanb@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.875820323@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.875820323@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:15PM +0100, Peter Zijlstra wrote:
> In order to avoid yet another linear search of (20k) sections, add a
> name based hash.
> 
> This reduces objtool runtime on vmlinux.o by some 10s to around 35s.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

$SUBJECT needs "objtool: " prefix.

-- 
Josh

