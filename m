Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BCB20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOXEiEAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgCaABW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:01:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43833 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729398AbgCaABV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585612880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWMGIyM+EQlmNpNdyc1krEzJQU9C++X/ouqCdGDz9GY=;
        b=XOXEiEAaKLL/qWGDodJinds4T46g/a6BWON8Cvzvzytci53i2ANmGaFSRk0bFGAEA+2Soc
        oPx8rq0/KVVmu7drtENOaWuAgOD0dlYnIdI7FwtYos3tnR8OmfySmLHX/oPL3bEntZGFg1
        TfJrAHHY5qX0UcjKWxn+H1pj/PoELGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-9ovAUwVxO5em1mdQuZEQdA-1; Mon, 30 Mar 2020 20:01:16 -0400
X-MC-Unique: 9ovAUwVxO5em1mdQuZEQdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B41800D50;
        Tue, 31 Mar 2020 00:01:14 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D362100EBB6;
        Tue, 31 Mar 2020 00:01:09 +0000 (UTC)
Date:   Tue, 31 Mar 2020 02:01:03 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: vt6656: add error code handling to unused
 variable
Message-ID: <20200331020103.13008f53@elisabeth>
In-Reply-To: <20200330233900.36938-1-jbwyatt4@gmail.com>
References: <20200330233900.36938-1-jbwyatt4@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 16:39:00 -0700
"John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:

> Add error code handling to unused 'ret' variable that was never used.
> Return an error code from functions called within vnt_radio_power_on.
> 
> Issue reported by coccinelle (coccicheck).
> 
> Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
  ^ This should be dropped unless Quentin agrees to this version as well

> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

