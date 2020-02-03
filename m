Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0568F2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhoEMpO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBCQyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:54:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40194 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgBCQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:54:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id t204so14869076qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1S0FfEEKYpfNf2PHwM/KCXE+0wVLITciZdSUsbfByPA=;
        b=FhoEMpO4niuScf5dj1+tSyUUbYw4dm6juWWHA5MQhe0OUo2GSTPnTVF10YVxC8VZng
         euyK6S559zJaRAUEpeebtq7IeweWrAGt+aFxaU+I5QiuT08XmqM7DuriN5V2K/flqaz5
         JS17lz6BLYYwnuPVDwt4QPufyS2YfGGAvLXEgVGbgqD+vrG/9NY2KQKi8pfJcETpxbGj
         pigtRszzEIqXMIqOEAMu99oq+kqb3rzbXP3GkRT0aZVkQdh5ssgPG5FIbxtW/miH4Cy1
         t9/GF5kf0I6Q53NKxr3P2T2OI/ND4DKCY1HFG58eQvUulWDd6h/Meu5ZnH4lS+Vqafju
         EPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1S0FfEEKYpfNf2PHwM/KCXE+0wVLITciZdSUsbfByPA=;
        b=NuSliwZ+hqJ+9Qb2DzurPnNc+/WgPdovfhcn/+FsHUgZQqBNJgnYuP+NMvy5bKNAVR
         QznZlf4HQWPWW6VReOHQfvprpp2UMd//Ym7BHaSomGhtFu/KENiHhEXPzLRxfS1gm0mZ
         lV3ZdvrXQG+myTH1EevXFMvchSN/Ri50+SfZuVBM6TFCEEuCySpPcUfylBXleZbvIjxG
         W50jIEzKUAVAx7EeAhIf+gxVTjl7S3gfNNrJDK7YNUqaEDQPHe6kHNDC6OROZxAnWaqj
         L7wvs/73da/tUDG9TderXdY+horkTVU+jpOJLpY+RG4QFY0QkZu1YbK0wZ601o4beRdw
         A/4Q==
X-Gm-Message-State: APjAAAUnY/TtnHqInyqhde+9e5iBBmAR1LrDp5BX+Kc29BpVd3AMttBe
        wcgtUugQXpbYaDkQD201gA6W2ge4
X-Google-Smtp-Source: APXvYqzRAo9+ulyrV8M5rHW/0rt2So6JDMYQXu8LpEq6QxVfs5kAbMVUbEa2U4MtDszEBn5EplACaA==
X-Received: by 2002:a05:620a:a46:: with SMTP id j6mr25318517qka.164.1580748857929;
        Mon, 03 Feb 2020 08:54:17 -0800 (PST)
Received: from gateway.troianet.com.br (ipv6.troianet.com.br. [2804:688:21:4::2])
        by smtp.gmail.com with ESMTPSA id 65sm10362685qtf.95.2020.02.03.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:54:17 -0800 (PST)
From:   Eneas U de Queiroz <cotequeiroz@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>
Subject: [PATCH 0/2] crypto: qce driver fixes for gcm
Date:   Mon,  3 Feb 2020 13:53:32 -0300
Message-Id: <20200203165334.6185-1-cotequeiroz@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally managed to get gcm(aes) working with the qce crypto engine.

These first patch fixes a bug where the gcm authentication tag was being
overwritten during gcm decryption, because it was passed in the same sgl
buffer as the crypto payload.  The qce driver appends some private state
buffer to the request destination sgl, but it was not checking the
length of the sgl being passed.

The second patch works around a problem, which I frankly can't pinpoint
what exactly is the cause, but after some help from Ard Biesheuvel, I
think it is related to DMA.  When gcm sends a request in
crypto_gcm_setkey, it stores the hash (the crypto payload) and the iv in
the same data struct.  When the drivers updates the IV, then the payload
gets overwritten with the unencrypted data, or all zeroes, it may be a
coincidence.

However, it works if I pass the request down to the fallback driver--it
is used by the driver to accept 192-bit-key requests.  All I had to do
was setup the fallback regardless of key size, and then check the
payload length along with the keysize to pass the request to the
fallback.  This turns out to enhance performance, because of the
avoided latency that comes with using the hardware.

I've started with checking for a single 16-byte AES block, and that is
enough to make gcm work.  Next thing I've done was to tune the request
size for performance.  What got me started into looking at the qce
driver was reports of it being detrimental to VPN speed, by the way.
I've tested this win an Asus RT-AC58U, but the slow VPN reports[1] have
more devices affected.  Access to the device was kindly provided by
@simsasss.

I've used the openssl speed util to measure the speed, with an AF_ALG
engine I've written to make use of the kernel driver from userspace[2],
running on 4.19.78--I can't run this on a newer kernel yet.

TLDR: In the worst (where the hardware is slowest) case, hardware and
software speed match at aroung 768 bytes, but I lowered the threshold to
512 to benefit the CPU offload.

Here's the script I've used:
#!/bin/sh
for len in 256 512 768 1024; do
  echo Block-size: ${len} bytes
  for key in 128 256; do
    for mode in cbc ctr ecb; do
      rmmod qcrypto
      openssl speed -elapsed -evp aes-${key}-${mode} -engine afalg \
                -bytes ${len} 2>&1 \
        | grep ^aes \
        | sed "s/aes-${key}-${mode}     /aes-${key}-${mode} soft/"
      insmod /tmp/qcrypto.ko
      openssl speed -elapsed -evp aes-${key}-${mode} -engine afalg \
                -bytes ${len} 2>&1 \
        | grep ^aes \
        | sed "s/aes-${key}-${mode}     /aes-${key}-${mode} qce /"
    done
  done
done

Here's a sample run--numbers vary from run to run, sometimes greatly:

./test_speed.sh
Block-size: 256 bytes
aes-128-cbc soft  6808.92k
aes-128-cbc qce   2704.10k
aes-128-ctr soft  6785.63k
aes-128-ctr qce   2675.07k
aes-128-ecb soft  7596.86k
aes-128-ecb qce   2772.16k
aes-256-cbc soft  5970.02k
aes-256-cbc qce   2678.84k
aes-256-ctr soft  6164.46k
aes-256-ctr qce   2634.15k
aes-256-ecb soft  6529.03k
aes-256-ecb qce   2720.88k
Block-size: 512 bytes
aes-128-cbc soft  9402.31k
aes-128-cbc qce   5345.69k
aes-128-ctr soft  9766.23k
aes-128-ctr qce   5179.25k
aes-128-ecb soft 10638.85k
aes-128-ecb qce   5437.13k
aes-256-cbc soft  7742.98k
aes-256-cbc qce   5230.08k
aes-256-ctr soft  8174.93k
aes-256-ctr qce   5115.89k
aes-256-ecb soft  8772.61k
aes-256-ecb qce   7282.35k
Block-size: 768 bytes
aes-128-cbc soft 10466.38k
aes-128-cbc qce   7814.59k
aes-128-ctr soft 11161.69k
aes-128-ctr qce   7639.93k
aes-128-ecb soft 12122.37k
aes-128-ecb qce  10764.84k
aes-256-cbc soft  8725.50k
aes-256-cbc qce   9184.41k
aes-256-ctr soft  9233.15k
aes-256-ctr qce   7392.32k
aes-256-ecb soft 10039.30k
aes-256-ecb qce   9148.45k
Block-size: 1024 bytes
aes-128-cbc soft 11418.80k
aes-128-cbc qce  12314.37k
aes-128-ctr soft 11940.86k
aes-128-ctr qce  11982.51k
aes-128-ecb soft 13350.23k
aes-128-ecb qce  10375.28k
aes-256-cbc soft  9003.32k
aes-256-cbc qce  12017.66k
aes-256-ctr soft  9898.89k
aes-256-ctr qce   9672.18k
aes-256-ecb soft 10679.74k
aes-256-ecb qce  12314.37k

I imagine that if I were to run the benchmark within the kernel, the
resulting threshould would be eve higher, since there's a pretty much
fixed latency from the context switches.  Nonetheless, I think it's
better to let the engine run more, to offload the CPU.

Cheers,

Eneas

[1] https://forum.openwrt.org/t/ipsec-performance-issue/39690
[2] https://github.com/cotequeiroz/afalg_engine

Eneas U de Queiroz (2):
  crypto: qce - use cryptlen when adding extra sgl
  crypto: qce - use AES fallback when len <= 512

 drivers/crypto/qce/dma.c      | 11 ++++++-----
 drivers/crypto/qce/dma.h      |  2 +-
 drivers/crypto/qce/skcipher.c | 17 +++++++----------
 3 files changed, 14 insertions(+), 16 deletions(-)

