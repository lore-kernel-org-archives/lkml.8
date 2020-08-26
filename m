Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D01CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D761F207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="rRl+Udx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHZTwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgHZTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:52:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2403C061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:52:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so1594245pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VbJ9M0x7/6kdVUf5kyNPDEStbpnR2XDArodticGgnuw=;
        b=rRl+Udx0c/tGT5sCZv6zDX1U97/r6hjWIJ1etf9yfwwvdhzwi+WnMpG8Qgm/MUoHJn
         Ee4rGok0Wx4355BscUdPeV2RoMj6B5E9CiOF1MWXin/kkuRtjLAxhVt7FzOKKIYCnDBn
         wy38Xp0nqiwlcVZ3HoDTBTTB6GOwKFLhD1XGxB8Ud1p55FRo9REe8djvCD/9myaSshs3
         pjoSDjYgzeOQpVP3xPaYQ9LXXofKLVXT40825djtQaGq8HL3SUKL6UlGHfyYMFZ+v4zC
         bEhMqDfO7oUnl3LMOLhPUPzJnm4Zr4xu6TxhiveZ1ND+AULjsg25FkSiel1XDB2cxyNn
         l84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VbJ9M0x7/6kdVUf5kyNPDEStbpnR2XDArodticGgnuw=;
        b=IY/Xl+HNb4YLyXYlP9Z73ljSyERnlLkbbZhznWk6f680b3VU5picK6RYc47k9Z5SjB
         PQvqRUvDkeximZ2M9OBBDFzta/K8JTSz61nM9bIdlgo/sAR6RrJXXOAb1tJ1icp3RAsl
         1zP4WrpoLQ+mfHsVUVp4lDvGUZXDQDje2QN+EID9fDMsogpLRNVOCDFRCO0OAj8K7kvL
         xi0lK9oMWCjEkLJxFXOxLsYcvdh5RlD6fJqWjHgIqs+aFeMlovfwAVui6EM/M1fGgQ/B
         U6bDF8eDL1035Rp5SysIkb229IERDUIbGFjvAICc7cqfo0D1BJAemdb0JWugYXl7tNb5
         aSAw==
X-Gm-Message-State: AOAM530qZG57JZL58qHvHnYWK7JHEO0ETmWKvRF9vVoIUjEy7ix/v/xZ
        2P/BeTh0a9GseGFC0MLNfYmgvt6P5xLz2QxzTww=
X-Google-Smtp-Source: ABdhPJz2tJUnfEf0SqTON1++961s4mS80Ys4vUdtGo5FqM5ZbNWVgz7JG4vIUMYBfxdhxOnPXyMo2A==
X-Received: by 2002:a62:f843:: with SMTP id c3mr13624152pfm.247.1598471562130;
        Wed, 26 Aug 2020 12:52:42 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b16sm3740431pfo.187.2020.08.26.12.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 12:52:41 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C1F49852-C886-4522-ACD6-DDBF7DE3B838@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_97ED6957-F79E-438A-BEE2-A42EA0D99B36";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 1/3] io_uring: use an enumeration for
 io_uring_register(2) opcodes
Date:   Wed, 26 Aug 2020 13:52:38 -0600
In-Reply-To: <202008261241.074D8765@keescook>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>, io-uring@vger.kernel.org
To:     Kees Cook <keescook@chromium.org>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-2-sgarzare@redhat.com> <202008261241.074D8765@keescook>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_97ED6957-F79E-438A-BEE2-A42EA0D99B36
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 26, 2020, at 1:43 PM, Kees Cook <keescook@chromium.org> wrote:
> 
> On Thu, Aug 13, 2020 at 05:32:52PM +0200, Stefano Garzarella wrote:
>> The enumeration allows us to keep track of the last
>> io_uring_register(2) opcode available.
>> 
>> Behaviour and opcodes names don't change.
>> 
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
>> 1 file changed, 16 insertions(+), 11 deletions(-)
>> 
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index d65fde732518..cdc98afbacc3 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -255,17 +255,22 @@ struct io_uring_params {
>> /*
>>  * io_uring_register(2) opcodes and arguments
>>  */
>> -#define IORING_REGISTER_BUFFERS		0
>> -#define IORING_UNREGISTER_BUFFERS	1
>> -#define IORING_REGISTER_FILES		2
>> -#define IORING_UNREGISTER_FILES		3
>> -#define IORING_REGISTER_EVENTFD		4
>> -#define IORING_UNREGISTER_EVENTFD	5
>> -#define IORING_REGISTER_FILES_UPDATE	6
>> -#define IORING_REGISTER_EVENTFD_ASYNC	7
>> -#define IORING_REGISTER_PROBE		8
>> -#define IORING_REGISTER_PERSONALITY	9
>> -#define IORING_UNREGISTER_PERSONALITY	10
>> +enum {
>> +	IORING_REGISTER_BUFFERS,
> 
> Actually, one *tiny* thought. Since this is UAPI, do we want to be extra
> careful here and explicitly assign values? We can't change the meaning
> of a number (UAPI) but we can add new ones, etc? This would help if an
> OP were removed (to stop from triggering a cascade of changed values)...
> 
> for example:
> 
> enum {
> 	IORING_REGISTER_BUFFERS = 0,
> 	IORING_UNREGISTER_BUFFERS = 1,
> 	...

Definitely that is preferred, IMHO, for enums used as part of UAPI,
as it avoids accidental changes to the values, and it also makes it
easier to see what the actual values are.

Cheers, Andreas






--Apple-Mail=_97ED6957-F79E-438A-BEE2-A42EA0D99B36
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9GvYYACgkQcqXauRfM
H+CDqw/+M9+szTISRR0mIIv0L6q5oHSmmJFu6N4WmXH9ZZfUYkGvC7f4CTNhd2k5
mF1lXbrMAF4i2/0Aui4WjWC5UoW77PBFwOpPYrTw/dbF16AbXEw1HoFamlgZ1Ote
APczb6wzuFTYYdN9rgX+jdSDUBnvjmdomJz++4ZmScTqTOzUHBkgIS7O4Lw+O6o/
Hu9oXp/VS3WvHQyDFYFAuaUR+UPAUeOec4AXfRNbC0RdadsFKtNZKI5p3VV16I3v
v5M9vGUxH/bweRVwBe7w2J0X0mQvtOKwXYVEFxpUrIHIMMzxBKx1FY8KbMpudyPB
lgECtvuCo+fDQrEMZ7xaE8xclFQa0ts/YnHFi9qrPHH0AvtNY+zA//OQjBNm06tc
t8uKkMnPuxWDv5krYrFZhtM9DM/YKJrdSf4Bq08u9aiRKYkE0HgoS3J7pZ9Vq2Kz
+d2RFoEm0cpZMW5ut7jbcXO1tW1RnXadKCkvoVcYZ2yK+WytE5Y+S5vXg7jtLpML
PKKWgX6hxJPQ3Nz+DOQGvnNQ/Xr0eT7BF2d9BSu2q5B4+s+NPKLunjnFZaWiAq5g
Y2okqZKRc2hdkb+fAG0Qn3dTLJ/PooXW2V0zaTGI7Nx7KgqaAI+w/mb8TX48BhAk
ZCjtvI/znZFgtzZjuDIfSa1pN2K2VJPBYla1Bdrx7r+CEhA7mEY=
=gPQ0
-----END PGP SIGNATURE-----

--Apple-Mail=_97ED6957-F79E-438A-BEE2-A42EA0D99B36--
