Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB1C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88C0206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSWOdsI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgCKREq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:04:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45465 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729675AbgCKREp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583946284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jykx3cJByb3AWCb0WV64LkUlnx3R9Hi3e1lE7ij8ROg=;
        b=XSWOdsI7jKXGkxrXUz+LY5oZdm1+A3z30b0kLKFdo823TlBRLLUqTsBd+bcDZIabFwC1Ig
        5c/VL2s/FGhWhSl/6DWxfhyoo0hCVTjrDIDrz91fufSlkU6RBWhUDSSK4YspLSiPy2i33o
        Gc50xMUqvnZLKtE9DFesBAw6tIWBQmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-fylXbBEaNUCy-xrSG-2R-A-1; Wed, 11 Mar 2020 13:04:39 -0400
X-MC-Unique: fylXbBEaNUCy-xrSG-2R-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07B451937FC0;
        Wed, 11 Mar 2020 17:04:38 +0000 (UTC)
Received: from elisabeth (ovpn-200-42.brq.redhat.com [10.40.200.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E1755D9C5;
        Wed, 11 Mar 2020 17:04:34 +0000 (UTC)
Date:   Wed, 11 Mar 2020 18:04:28 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH v4] Staging: rtl8188eu: rtw_mlme: Add
 space around operators
Message-ID: <20200311180428.6489fe9b@elisabeth>
In-Reply-To: <20200311131742.31068-1-shreeya.patel23498@gmail.com>
References: <20200311131742.31068-1-shreeya.patel23498@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 18:47:42 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Add space around operators for improving the code
> readability.
> Reported by checkpatch.pl
> 
> git diff -w shows no difference.
> diff of the .o files before and after the changes shows no difference.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

This looks good to me. Further clean-ups here could probably make this
look less messy (there are long lines, unnecessary parentheses that are
rather confusing, especially on that 4/5 factor, "magic" constants that
might make sense to figure out the meaning of, etc.).

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

