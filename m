Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3614C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F98217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSw79z8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBEWsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:48:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgBEWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580942894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cHEFoE8jbw7EqsKmYikm9pxnEO2ox+NzDcqYlTv6MQ=;
        b=VSw79z8S341pkxkeT52ZgajjfhnCKGJj2CDIswp+dYrzGvE8kT5tgD6jgkByy2xUHXNsjW
        C/Cor0QnOvXuf9izYiwcG7tJRQBHl+sWp9zlT5t1kK/7J4Al5WkcE41kIImGNKoUTlSQfs
        3nnpxGmBFTg42/EIITMIZQ0T2TISTFg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-yFc61YqEO5G2O45N8InLxg-1; Wed, 05 Feb 2020 17:48:13 -0500
X-MC-Unique: yFc61YqEO5G2O45N8InLxg-1
Received: by mail-qk1-f199.google.com with SMTP id b23so2316019qkg.17
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2cHEFoE8jbw7EqsKmYikm9pxnEO2ox+NzDcqYlTv6MQ=;
        b=hJSihFFMwFPVOjOZzqJfjbfMJrgqICA6lWZYuJPDNdX0Kdxi7OKe0HfAFfzd/izgeS
         LqoC50uFGiUBknuSObKmMuG2NCBllX42beevioOhojAByYx7Sk3yClO63U6UIkQqEZ93
         DiazheApkRR1lkIPBqUXzDZYKhidgx7SS73tf51v63OYOqrVM4N8UyzVRmIFG3YjaO2c
         xbE8cZQH+YrcJ1AfmlzjsCrEbck5mJxpk0UDeIyio/0mI3T9RUxNhS1qWo6rs0/oK1gW
         IF20JHw2AxaoTnO11n7dGLwXIWpA0iBPZq0EdfuM50I/ZUQW9P2a3fWXQq1wd2ylEOmH
         oLAQ==
X-Gm-Message-State: APjAAAXDQtLGlOH1DULkPtu5YDgIO/MSCsT5+Lcifi3H3M2l56PVL8gn
        Cm44suBv1mo7GQ4ajSNYXRxSXoQ9Hx6jZH9m80Aiaz69MsPiUC2Lj+NETffRngotAUJNTdyNORB
        LUuUqfutoFTuD0R1AmNGz2Pr8
X-Received: by 2002:ac8:718e:: with SMTP id w14mr82095qto.266.1580942892810;
        Wed, 05 Feb 2020 14:48:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzidgvMzifyXKMl5xyBUEvf76nUThQJ4Vf+I9H3f+5mpj/6PKciWyQRPVlUWOeD9yt6R/onsg==
X-Received: by 2002:ac8:718e:: with SMTP id w14mr82077qto.266.1580942892562;
        Wed, 05 Feb 2020 14:48:12 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id s67sm562392qke.1.2020.02.05.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:48:11 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:48:09 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 08/19] KVM: Refactor error handling for setting memory
 region
Message-ID: <20200205224809.GI387680@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-9-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121223157.15263-9-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:46PM -0800, Sean Christopherson wrote:
> Replace a big pile o' gotos with returns to make it more obvious what
> error code is being returned, and to prepare for refactoring the
> functional, i.e. post-checks, portion of __kvm_set_memory_region().
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

