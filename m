Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9717C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902CC2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgCDNuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:50:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39418 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgCDNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:50:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so2388478edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 05:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUOxF6a7YWDCkJQKwMw5WU/iZ3kgnizQnBTCbTp/G3M=;
        b=MyiSU1JbjFjGSORVkRc8md7Tcvg9L+XkIdhImVKAjKPplj0Kb10arXNNMZpcPmLCsD
         A5jkThUaTIOl8LnC077eUjRIWDnGVtcuSrWOz55t08viRAdi5LWkJ93qhb7GrCpSHqgn
         2HjCf0S53zsx0RvZtvGLWNeERc6II/Ik7odzWQgGH/c6RaS2AVl49+fUuSnC+BthV0jn
         mmDSJADTBY1BrsBsum3OyFv5OAdqCsHcKz1xemS4+d6FWFBppLcrpIkgKiMsKtovs1E4
         SztbE1r6oUxnVyzF9hT3UPdpOgVU916GfZSUGi5cqMpU/YYwXA60zzPkm+4UVO30Uyz+
         n0Aw==
X-Gm-Message-State: ANhLgQ3AcZwJpDMJwCBWE4MKrXN5FpFZYmhafhfyBHCv0QPSRGH2GcsO
        J7UR8cORELYMrbnqw22qqHTwPewlDztPJg==
X-Google-Smtp-Source: ADFU+vvRs/8m17ncgBqBdzTJujYabyOfUGbiS2SlE8/I+XAXVPuKXJJGhzqox4bFzMMW7oq6yMBaTA==
X-Received: by 2002:a50:8a62:: with SMTP id i89mr2863379edi.173.1583329852681;
        Wed, 04 Mar 2020 05:50:52 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-232.amazon.com. [54.240.197.232])
        by smtp.gmail.com with ESMTPSA id s10sm714333ejr.2.2020.03.04.05.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 05:50:52 -0800 (PST)
Subject: Re: [PATCH v3 2/2] xenbus: req->err should be updated before
 req->state
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303221423.21962-1-dongli.zhang@oracle.com>
 <20200303221423.21962-2-dongli.zhang@oracle.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <3bc030fb-340e-434d-60a2-a54bce097680@xen.org>
Date:   Wed, 4 Mar 2020 13:50:51 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303221423.21962-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2020 22:14, Dongli Zhang wrote:
> This patch adds the barrier to guarantee that req->err is always updated
> before req->state.
> 
> Otherwise, read_reply() would not return ERR_PTR(req->err) but
> req->body, when process_writes()->xb_write() is failed.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Julien Grall <jgrall@amazon.com>

Cheers,

---
Julien Grall
