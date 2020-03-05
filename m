Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962E1208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RkT69pEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCEJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:51:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33751 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCEJv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:51:29 -0500
Received: from [IPv6:2601:646:8600:3281:d841:929b:f37:3a31] ([IPv6:2601:646:8600:3281:d841:929b:f37:3a31])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0259k9mj615657
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 5 Mar 2020 01:46:11 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0259k9mj615657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1583401572;
        bh=d3uk36S9Ty6MRwBU06LBDgFpBga8OPUr3RaLuQvKcLc=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=RkT69pEMwoDRqA7flEX01RVf8xBt7c8i+B0Dofc3n/oWvyXuJrbBO3qdQhZe2vVts
         4n2TB0D+SIMKfXC+EUVcAdJVei//hjscj3KyQUnMX+2uiw8Qak5jyYZTTcaqogLaSQ
         Mp8UQ+OlkrLC/NxY2tXDTOvnr4eEMc/CLyuMOVMwVlonTLn7CCAhbmhDVS9vTxsTBg
         F/HMF4A3o2seD+/iMBqyMCsr/N5n5f/pYtnTlJyp002jpw1TnGape3yKA9tdZALlbn
         Nso4JwQXPBYlHjERz1FjI3tnPCejaU+nBsj79dADEGC4e2BIA8FzAIxXtHEtB5YQxc
         AaPcyNX6jdeJw==
Date:   Thu, 05 Mar 2020 01:46:03 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200305093318.12235-1-chen.yu@easystack.cn>
References: <20200305093318.12235-1-chen.yu@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/cpuid: Use macro instead of number in cpuid_read()
To:     Yu Chen <chen.yu@easystack.cn>, tglx@linutronix.de
CC:     linux-kernel@vger.kernel.org, x86@kernel.org, yuchen1988@aliyun.com
From:   hpa@zytor.com
Message-ID: <83699764-1956-4C58-8347-41A29A0687C4@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2020 1:33:18 AM PST, Yu Chen <chen=2Eyu@easystack=2Ecn> wrote:
>Make and use macro CHUNK_SIZE, instead of numeric value 16 in
>cpuid_read()=2E
>
>Signed-off-by: Yu Chen <chen=2Eyu@easystack=2Ecn>
>---
> arch/x86/kernel/cpuid=2Ec | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
>diff --git a/arch/x86/kernel/cpuid=2Ec b/arch/x86/kernel/cpuid=2Ec
>index 3492aa36b=2E=2Ef7d7e0ef7 100644
>--- a/arch/x86/kernel/cpuid=2Ec
>+++ b/arch/x86/kernel/cpuid=2Ec
>@@ -48,6 +48,9 @@ struct cpuid_regs_done {
> 	struct completion done;
> };
>=20
>+/* cpuid must be read in chunks of 16 bytes */
>+#define CHUNK_SIZE	16
>+
> static void cpuid_smp_cpuid(void *cmd_block)
> {
> 	struct cpuid_regs_done *cmd =3D cmd_block;
>@@ -69,11 +72,11 @@ static ssize_t cpuid_read(struct file *file, char
>__user *buf,
> 	ssize_t bytes =3D 0;
> 	int err =3D 0;
>=20
>-	if (count % 16)
>+	if (count % CHUNK_SIZE)
> 		return -EINVAL;	/* Invalid chunk size */
>=20
> 	init_completion(&cmd=2Edone);
>-	for (; count; count -=3D 16) {
>+	for (; count; count -=3D CHUNK_SIZE) {
> 		call_single_data_t csd =3D {
> 			=2Efunc =3D cpuid_smp_cpuid,
> 			=2Einfo =3D &cmd,
>@@ -86,12 +89,12 @@ static ssize_t cpuid_read(struct file *file, char
>__user *buf,
> 		if (err)
> 			break;
> 		wait_for_completion(&cmd=2Edone);
>-		if (copy_to_user(tmp, &cmd=2Eregs, 16)) {
>+		if (copy_to_user(tmp, &cmd=2Eregs, CHUNK_SIZE)) {
> 			err =3D -EFAULT;
> 			break;
> 		}
>-		tmp +=3D 16;
>-		bytes +=3D 16;
>+		tmp +=3D CHUNK_SIZE;
>+		bytes +=3D CHUNK_SIZE;
> 		*ppos =3D ++pos;
> 		reinit_completion(&cmd=2Edone);
> 	}

It would make more sense to define a structure and add it to a uapi header=
=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
