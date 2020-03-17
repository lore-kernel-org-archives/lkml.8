Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40BCC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2D920770
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dDM04G1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQNkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:40:43 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:25049
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgCQNkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw90KXZ5NJnIWqWEgIlxmf3XzP987sNaeJrMjkSJMXZB6xiOxbFIXIuVxxDXiGmBtspT6LFj+n5zxb6bpVRkLB2Ap6bQo4RliuRq8elZnx3y5N84CN0jTnQkf7pjvzPKOmiyokebYgQ6c6c6bosqX1lbjzyBBiEg32XNv1XWjxO2VPhXhsB1RXTMxUInrd2sXd5gWgcpj0AD82HWNhBjXcSVvmS5NnPZyPDuDvy+pnWvY5fRyCN2nzqWRyGxLwsvxaHRhPop1eiPMGl/0e+Z4a+/n08YVgEM3Ue4FHDA0maWWmAh6MbeNXBGwcQR67Ul2HtlqjkTwrT+s+e7EgOLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37YsdWVN4D26rTI0zHPcDLtb+DiBkopbTPHGnlyhSg8=;
 b=mkegSc4isq3lwiZ5EZ8ONoa0sfZmA3QAcW8D9JRCgzJoydVZNtMuRxQ5EiJ7DyKRq2uGcB5P4rFJvPqPKGNZDFVgcUtD93ORUq26+1DIkYSeq79DRKgYIlSqMSWgaJ6bFQmt57Xly1Nq2zD+5t3IhUMolhHsc/Uino4Qx90WqwNL2kjz3X9AuoLmfzw5ZV6CrAJ7h1Ki62RkxoR/5bIeKiRoAq5e1Sj20+HAuYtaLQk5hQpN25I2Ew/LDRt5ZWbv8ijcdox0vEc0a/At0rcBZ4AdbgvIHgAKb+1gOyw/ltktUOrdzUfHt8OMwBxb1z2tiK1wuQ8xQdGEtawnA1W32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37YsdWVN4D26rTI0zHPcDLtb+DiBkopbTPHGnlyhSg8=;
 b=dDM04G1MHkr5tN1iaG5xF34onzaDq8PAR+fd9vzv4d4p3YAAqrfatqI3z7vGlOUzAXQArdFFBV2FoOweZEAB+qmHaCDxBmWkeumFSophbnrWoWds8rxcOGDViWUv1r4F+mo3bTDnLryOz0MBxitNWiSrdRYNjRPcPTGyrt38H60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 13:40:03 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:40:02 +0000
Date:   Tue, 17 Mar 2020 09:39:59 -0400
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com
Subject: Re: [PATCH] Staging: drm_gem: Fix a misaligned comment block
Message-ID: <20200317133959.pdimegprq3gn4gsf@outlook.office365.com>
References: <20200316211553.2506-1-igormtorrente@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2kyrwqlv7u5mtxbp"
Content-Disposition: inline
In-Reply-To: <20200316211553.2506-1-igormtorrente@gmail.com>
X-ClientProxiedBy: YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Tue, 17 Mar 2020 13:40:01 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bda85423-3b06-4162-41b9-08d7ca78b1de
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Antispam-PRVS: <MW2PR12MB23649BFA24B1B759E9258C9E98F60@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(81166006)(478600001)(81156014)(966005)(6916009)(8676002)(16526019)(186003)(55016002)(8936002)(4326008)(7416002)(9686003)(7696005)(52116002)(5660300002)(44144004)(86362001)(21480400003)(66476007)(66946007)(1076003)(66556008)(316002)(2906002)(6506007)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:MW2PR12MB2524.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb3uXOR2/nhm5sRVD3PM1bdGHOWndSH2kP+iqR06cqFcKwct5wRlBLb3eEFHxqEyi1fHXMhowLGoAAgWnextc88nW2Xzq4v4IrAiHYfo5uTHdJSITZkYvVprz0XzteWP6YvN+f3r/dOJS6X/+DRnKPtbI2+HcwpAUT8nNXFt5JhXX9ycDqkm0NzhLrepjWDjVf2x+sYiLvLVi+/YYfbe79sELyc8wFnhKHLvyEKBUUKpUuIyBB/7gautFRTWsw07Sv0A4BGn9r7DCuEh/PMcPDzmE9LmYTelRCfE7aNjoG8/rLsVKD1uWjA6Mi1AavDX7ShAu8nekbGBgjBTs7roM4eNz50454jhsFbKSiT/wgiU8Zbly8z/GbDdifiXanqzbKtEc8yMTFG+tYaWYNxbQ48M9vYMevcTcnruRzem//CCn125ISaC2XFQlDvtyYJXbuRlCWmvGOU+oyVU/nrVY/w+orSoau5ssVDO9FTHugusO0qhsZtZdSf9mEhCDKORkA8YQ7Oq+cEmY4OVgjkvRYlmZLL9bDB7P7dVV8kS6IwpNjUOb9oer6aupOtPEdczS80byRbo67QJHBkDEx8hoDYqc/OAG+EbNwC8m37Ha+reH33DaqxoHFJJLi8isjJGbtaXqk8/ZRNiMZpQIl51Wg==
X-MS-Exchange-AntiSpam-MessageData: R4RkqcGsI1kIYLvvbFPIMuOtjgk+ykjKJsTX61kdR+cRnY3ab5aDxK0R1pEdlCjRwfHgIcKUk7gjlk13nJIOlVVM6rslL6zh4s2bnu4qOm6zxb3SErzhgoiTS1hInggiK6oX5Q29oJNADSjZN2CZaGNPEiqQoEJ65fI3ZQFlEa0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda85423-3b06-4162-41b9-08d7ca78b1de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:40:02.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibUbNi9oFciGQVL4mN1H90CfDc6CyT4pvKlLewbxOlGs2AKpPC3k70OwgfR3VaNVAsCNkhX22/wptPr9/RM/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2kyrwqlv7u5mtxbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Igor,

First of all, thanks for your patch.

Just a few suggestions:
* Avoid using "Fix" in this sort of patch. Usually, we use "Fix" for
  indicating a bug fix or similar. You can read more about it here:
  https://kernelnewbies.org/PatchPhilosophy
* Patch subject format may vary between subsystem, however, I recommend
	you to follow the instructions from this page:
  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

In summary, I just recommend you to improve the commit subject for your
V2.

Thanks

On 03/16, Igor Matheus Andrade Torrente wrote:
> Fix a checkpatch warning caused by a misaligned comment block.
>=20
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 000fa4a1899f..6e960d57371e 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -222,10 +222,10 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_o=
bject *obj)
>  		return;
> =20
>  	/*
> -	* Must bump handle count first as this may be the last
> -	* ref, in which case the object would disappear before we
> -	* checked for a name
> -	*/
> +	 * Must bump handle count first as this may be the last
> +	 * ref, in which case the object would disappear before we
> +	 * checked for a name
> +	 */
> =20
>  	mutex_lock(&dev->object_name_lock);
>  	if (--obj->handle_count =3D=3D 0) {
> --=20
> 2.20.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--2kyrwqlv7u5mtxbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5w0yoACgkQWJzP/com
vP87bxAAv1ThCByaUiPe9+Gk9mq15AT44DkzUnZ6Qy2cwY7jA4BOvMXCvuLSa21p
SByYl68VtCfRWALMPIT6rVnhK1ok/dB+qHkxa1exxK27GveRtpuDqGnmhhYCuB/9
mEgUXAtEiuhfcWvpxrFoCRv48Eva0cly583RyOmtdFd5aQTuxEEmdLINZaoI8+jz
uBcHzOS0JP5PPuYoqtYl/gc7l+SAXiRYCXiR30AMdBGSfwefNVupxtLWJhe1Fge1
j4yNdDLVqE+FF5DvFtEWTTTeKWJUfjJUFtPAq/uZIetNKLUKvKqGDBZ3JJfNAcpS
wn/n+pPyixNxiGH9qO/feK8l1TL/nRsPNgxybqrOdKyOdhrH5HCfw5kUxkbkwJcq
iP6jGRpnTWJhkaP8YkD+/5FA4X3GpXJRLr/ZsZWqLfp7ZN7Ffyzr5SMkL6yYD3NH
JPmFvwQoPzTRxIy1efnL2NePq7P86VmGlfsJzPztLu0+JV+KE+8D6kx5Tp4cnguL
YFWs5FlM3EdWR8xQwE0pU9Gj0SSJ7KGtfx2dtq/JQvEp3nrGME84ovQLRziZizn8
KGfXoS/FaIfaAfLJNIra1Bpr6ERNM/83YuqPXhJhWKn/sUivpD1oYCEIZOPAz57E
AAZzmYurNDwsTgBJvT/O+wqTBeZMfyi2s5EOiP08GJOCHv3ZzIQ=
=mIpG
-----END PGP SIGNATURE-----

--2kyrwqlv7u5mtxbp--
