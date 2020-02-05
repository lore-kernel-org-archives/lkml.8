Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87FBC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4082085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6qCyz0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgBEFeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:34:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38606 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgBEFeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580880842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpoA79PTiO2rp87/4RjJ0Oaw1CL7CM0sYNu+diR+ohU=;
        b=g6qCyz0sGTDSfWDlqn1tcafxWSNTrYjr8duwJAvjkl4UiZzf9+qsVhntYUYHtElEavLDty
        0xmqencx0UBit5uWnps2XVyUvCpO7je4r3QxFGLoajc3gMMkW+BZZZbUsQeMrkcH0EpwnX
        ayiSzmVUb0HZVjwXyMGJJ71iSUWNSeY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-UWeRTNpcOL2wA2h0ozUu2g-1; Wed, 05 Feb 2020 00:33:58 -0500
X-MC-Unique: UWeRTNpcOL2wA2h0ozUu2g-1
Received: by mail-qk1-f198.google.com with SMTP id f22so568261qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 21:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpoA79PTiO2rp87/4RjJ0Oaw1CL7CM0sYNu+diR+ohU=;
        b=bW5BO8rKOh96aMEQYKmP1/7Wf2Q8LMf0tlSV0mK0Tq1dn6GO+4nveu/oySY2WYY/it
         9iKZBwhZPLCGxXQ/6SiQfULnNM/1f2q1/nWIdHY6Sn3AU8n/SXksy0zp722ZY1cbfGIW
         TWQ9MMG69fBTob5Myzgj9foVJbOJo4FoXLwRyPiUL9WIebxrn5uKVuP0mvY79icRLLNi
         Seir4EfxAnYnQqnTl/7H9AQr+G63g8HmQX+VPDvBXg7Zj/Lp8ZnzWJwZbO/xRpwYaVEw
         +khCotCOS0CMYehmxVMRLZOpdveM1x+SDdd00teEmbnahxdBvSLB51SU4eRdRRwzbPA6
         sTeA==
X-Gm-Message-State: APjAAAXdh4KppxskdYugBYxinQPNdb/URsi1i/fbphV8UHipi+lHAXyg
        4ryNvsIM59hvvXHn8nzaL769PBcIoJaZ4fQtq5I0JRfWsdvO0G8S0f1fQURPH8cgqCitYnB1Zdk
        0z8a2H45z+qp+pzcJxRs7S+tP
X-Received: by 2002:ae9:c10b:: with SMTP id z11mr31554692qki.157.1580880838437;
        Tue, 04 Feb 2020 21:33:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPyGS4sGVa29gfwEv/nW9Jz92sfCSHCicovqzsWK08mnYnXlDIxmWkXBF3U8uJQk1Lyqq61A==
X-Received: by 2002:ae9:c10b:: with SMTP id z11mr31554675qki.157.1580880838213;
        Tue, 04 Feb 2020 21:33:58 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id r3sm3624696qtc.85.2020.02.04.21.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 21:33:57 -0800 (PST)
Date:   Wed, 5 Feb 2020 00:33:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc:     jasowang@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, kuba@kernel.org,
        andriin@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4] virtio_net: add XDP meta data support
Message-ID: <20200205003236-mutt-send-email-mst@kernel.org>
References: <8da1b560-3128-b885-b453-13de5c7431fb@redhat.com>
 <20200204071655.94474-1-yuya.kusakabe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204071655.94474-1-yuya.kusakabe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:16:55PM +0900, Yuya Kusakabe wrote:
> @@ -852,8 +868,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			 * adjustments. Note other cases do not build an
>  			 * skb and avoid using offset
>  			 */
> -			offset = xdp.data -
> -					page_address(xdp_page) - vi->hdr_len;
> +			metasize = xdp.data - xdp.data_meta;
> +			offset = xdp.data - page_address(xdp_page) -
> +				 vi->hdr_len - metasize;
>  
>  			/* recalculate len if xdp.data or xdp.data_end were
>  			 * adjusted

Tricky to get one's head around.
Can you pls update the comment above to document the new math?

-- 
MST

