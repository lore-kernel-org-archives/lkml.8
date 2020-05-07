Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444D4215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFDH1Kl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgEGSWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:22:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59184 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728279AbgEGSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588875761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTb6Jgxz0ykVKPeNAv5nqgXZUkMIvK3Ny3fqxRZnxuU=;
        b=FFDH1Kl/Pi/jwbCm25DnpKwaeNEQxMTMoTCEaiOTWzt1wIiu+qEYUlU+BfcfA2D770ZYnA
        KZfVvqP1rGb9IFqEMgGo75jav33cE5BvDQsn79FgB7sc7Zr2SJHnsLDaNZaNs8Ahmbc9oB
        iAAV6vDtbQLmDWNDTQnK/09F/SkXDRE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-mMwC4rehO2yiHxIR3Tm9mw-1; Thu, 07 May 2020 14:22:39 -0400
X-MC-Unique: mMwC4rehO2yiHxIR3Tm9mw-1
Received: by mail-qk1-f200.google.com with SMTP id a18so6756573qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FTb6Jgxz0ykVKPeNAv5nqgXZUkMIvK3Ny3fqxRZnxuU=;
        b=SYswSNO6nmr1iX5bA8Q6oDzF0fpv5p73TXbFHP10F9jtutQIVquPCcwyQeqrhETIVC
         nQi4tb3dNNjXPVgtTazclZ2xFCv6hbzLJoG/+UGW8ZWPZnSayfhA7FDMWxjy7sWwbhSv
         RkSS6B92TAKqXlG7g72FoFrwIvFSZeUkyHrnqP2QF4AUtG2Lv0B2gFlySlNrYz624moO
         HUVdooBaBqU52XqLucbw6ES33MxqMDml+wJKbzNxnCBKASQ1q96ow+LJiPoKxGq8jr4e
         vy0e+xBfNTn82YELRMha4qS7zSGsQXB3mtMckXtkOoRYjeTlLgsaNafpx+VBkxdzMs0G
         BE1w==
X-Gm-Message-State: AGi0PuZeBIqE3creoPCm3sbSd1LXnYKDkva+V7LkpbJwxPhtnDadXhgX
        GjM37GdV+5jBwgQ9iKabEyweboKZIj+OWGcEL40t9s6xMbEaIR+Mf4M/YbcOL4p2UXQBX6Zf7Ky
        LllK0Ofvc1gW1154H5TxSXEUe
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr15208052qkb.131.1588875758748;
        Thu, 07 May 2020 11:22:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKCifR6UPiWN6/+9wr1Tx/y5vkRfYxk4HrSwoCiBdTYmZRrhZOsFmvk/nyG88T+rRN1zCXWaQ==
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr15208031qkb.131.1588875758550;
        Thu, 07 May 2020 11:22:38 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a17sm4857827qka.37.2020.05.07.11.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:22:37 -0700 (PDT)
Date:   Thu, 7 May 2020 14:22:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 6/9] KVM: nSVM: trap #DB and #BP to userspace if guest
 debugging is on
Message-ID: <20200507182236.GJ228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507115011.494562-7-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:50:08AM -0400, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

