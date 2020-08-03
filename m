Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AD52075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhsOo1fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgHCV0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:26:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgHCV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596490010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRtJQGNbvmgaLcvaxkwOS7vH+SUEibACGG1bnindh24=;
        b=DhsOo1fJv0V5OIYq7CysiXQpV/SYXpISXqa+fPa+SNih5uzeJvrx8isgBIopA/9tvJahMM
        aooM+xrXrGH27g/mMYuOhkVLtJ+YsOhP2tqzDlvS/L1dID9dbatjCVrd8Z/Yvos3q8Af3X
        xrCPJqVvMRYU0JNV31m5GKo0Cw9NXUM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-kMKC7qJPPRae66OsdacJzw-1; Mon, 03 Aug 2020 17:26:48 -0400
X-MC-Unique: kMKC7qJPPRae66OsdacJzw-1
Received: by mail-ej1-f69.google.com with SMTP id q20so5427109ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=iRtJQGNbvmgaLcvaxkwOS7vH+SUEibACGG1bnindh24=;
        b=aWhrapHfJh75SVL4oOe9MAfJKAx4XVOFYLUZB1GlgPAwsaHKeooq1v3AmpBTb5a7ot
         I0x90mZ8yHB+QC4YsNuv2weWzdnKUDmVvvyVNO30ing0hGdei/YjyZvtSWJjoiov09l3
         5ix7FvK1imWPQXf0SRkpY7OnNGnZSZsJfEfg/rf+H5+DKxEhnrwYCC/Xx8OVzKVv98pJ
         vWBXrwZlenBcHP38ae425KoZoBXSJOsBrPFxD2CZrjBGmaOHItSAnfadhR4nyTOhP/ZR
         3Pfto35cezLQ1SADLFWQn3qHlfwNWkgSXxVekRqS3C0DD9zk/+j1vMYmltQKZlUJCnwl
         zrsQ==
X-Gm-Message-State: AOAM531/P5MAedHSCJs8ysgfwi20IoHTwKfLXNpFZM1KyIK9nj6DBcCN
        WaiKuaZVVK57kVTc/8dnf7dwALDfSRmn0cNz9R15i2gR8F+AY+WhbDBRbWrUfcvtNW5n6WtYU2C
        Al9rjr84RpOiexL9I1gjJ/rK3
X-Received: by 2002:a50:9e4c:: with SMTP id z70mr17274779ede.384.1596490007153;
        Mon, 03 Aug 2020 14:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiOz/r6BIu9VkOdQ1URaCztVYMV7EL3eZ1EToZBNUnt7wGWXQQoZarZ0Kjj1o9DJbuN2x5LA==
X-Received: by 2002:a50:9e4c:: with SMTP id z70mr17274769ede.384.1596490006986;
        Mon, 03 Aug 2020 14:26:46 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6449.dip0.t-ipconnect.de. [91.12.100.73])
        by smtp.gmail.com with ESMTPSA id dm5sm8476175edb.32.2020.08.03.14.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 14:26:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 05/24] virtio_balloon: correct tags for config space fields
Date:   Mon, 3 Aug 2020 23:26:46 +0200
Message-Id: <1E428D95-19D2-40BA-9C46-CA7B0D823A7E@redhat.com>
References: <20200803205814.540410-6-mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <20200803205814.540410-6-mst@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.08.2020 um 22:59 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFTag config space fields as having little endian-ness.
> Note that balloon is special: LE even when using
> the legacy interface.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Hildenbrand <david@redhat.com>

> ---
> include/uapi/linux/virtio_balloon.h | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virt=
io_balloon.h
> index dc3e656470dd..ddaa45e723c4 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -45,20 +45,20 @@
> #define VIRTIO_BALLOON_CMD_ID_DONE    1
> struct virtio_balloon_config {
>    /* Number of pages host wants Guest to give up. */
> -    __u32 num_pages;
> +    __le32 num_pages;
>    /* Number of pages we've actually got in balloon. */
> -    __u32 actual;
> +    __le32 actual;
>    /*
>     * Free page hint command id, readonly by guest.
>     * Was previously named free_page_report_cmd_id so we
>     * need to carry that name for legacy support.
>     */
>    union {
> -        __u32 free_page_hint_cmd_id;
> -        __u32 free_page_report_cmd_id;    /* deprecated */
> +        __le32 free_page_hint_cmd_id;
> +        __le32 free_page_report_cmd_id;    /* deprecated */
>    };
>    /* Stores PAGE_POISON if page poisoning is in use */
> -    __u32 poison_val;
> +    __le32 poison_val;
> };
>=20
> #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> --=20
> MST
>=20

