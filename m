Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C7C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE542074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KmXYnhcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgDWOzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:55:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40548 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgDWOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:55:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200423145536euoutp01bd96fd2b6c82695c57682e7aaad581c6~Ieqlve2kb2813928139euoutp01c
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:55:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200423145536euoutp01bd96fd2b6c82695c57682e7aaad581c6~Ieqlve2kb2813928139euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587653736;
        bh=4jBedYbVs9iPISb4SHRfEbPFJqP00QurHGBQmIMMH9o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KmXYnhcFiNWsqafuebllh6+baVzXgyJ35Y/K6QD6Tr++BrpHYhXI/OhzxCArk9+kT
         awrP/Wa4vz3+aJSzNTLu1EyVF/chzn0/E1cpk6K3JawP18fEosiwmFRyNcRTD4GgY0
         x8ANFqiUqjb/bkrr0fv5bwfosG9SGDYL1CID2ckY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200423145536eucas1p11d03e6479cd7a4ae7276a37b6d2c144f~IeqlZ1cJj3041030410eucas1p1Q;
        Thu, 23 Apr 2020 14:55:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.4A.60698.86CA1AE5; Thu, 23
        Apr 2020 15:55:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200423145536eucas1p1d17d340c8ac30b9e186bfaeaf593f1b4~IeqlFFyEW3041030410eucas1p1N;
        Thu, 23 Apr 2020 14:55:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200423145536eusmtrp14eaca221daa39987e6c63814679c691d~IeqlEWxNm1059810598eusmtrp1I;
        Thu, 23 Apr 2020 14:55:36 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-85-5ea1ac689cbc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.6B.08375.76CA1AE5; Thu, 23
        Apr 2020 15:55:35 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200423145535eusmtip16a9e68a9b4493120f55398ce1a99fd94~Ieqkkhsqz1968119681eusmtip1u;
        Thu, 23 Apr 2020 14:55:35 +0000 (GMT)
Subject: Re: [PATCH v2] console: console: Complete exception handling in
 newport_probe()
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        FlorianSchandinat@gmx.de, ralf@linux-mips.org,
        tsbogend@alpha.franken.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
Date:   Thu, 23 Apr 2020 16:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200423142627.1820-1-zhengdejin5@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7oZaxbGGTRPErV4OeEwo8WVr+/Z
        LDpnXmO0aF68ns3iRN8HVovLu+awWVzao2KxedNUZovDTQeZLXY9usnswOXRemk5i8fOWXfZ
        PT58jPN4d+4cu8fRlWuZPPbPXcPucb/7OJPH501yARxRXDYpqTmZZalF+nYJXBlnFjSxFTQK
        VEy99pq5gbGPt4uRg0NCwERi8Ra2LkYuDiGBFYwSbQcaGSGcL4wSy68fZ4dwPjNKLN03AaiM
        E6yj59cKqJbljBKXP0xhhnDeMkoc7H7GCDJXWCBK4uMxTpAGEQF1iZkt/SwgNcwC3UwSr083
        gE1iE7CSmNi+ihHE5hWwk1j8tpkJxGYRUJX4tvEDC4gtKhAh8enBYVaIGkGJkzOfgMU5gXr/
        7D8FFmcWEJe49WQ+E4QtL9G8dTbYQRIC99glln87ygRxtovEkxNN7BC2sMSr41ugbBmJ05N7
        WCAa1jFK/O14AdW9HRgCk/9BPW0tcefcLzaQ15gFNCXW79KHCDtKfNi1hA0SknwSN94KQhzB
        JzFp23RmiDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4
        Nz212DgvtVyvODG3uDQvXS85P3cTIzB5nf53/OsOxn1/kg4xCnAwKvHwGpQujBNiTSwrrsw9
        xCjBwawkwrvh4bw4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZ
        ODilGhj5nv5I0zVbwOnI/61jemo/t7mtjel+QaEydS2mvjUrwn0CV7i4lDb+6mq6uHq5n0fg
        5s+yU1LY3kWqPHmyL/SXtNIX4cylLb/eXz48UXn31Mdv90U08rOWZ2Quf2f6+fG61YILDshK
        Km2/Hvj12hoR6QlTEj++sfNJTNp052vezFc5+YfNzwcrsRRnJBpqMRcVJwIAhgtLnVoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7rpaxbGGfS/trJ4OeEwo8WVr+/Z
        LDpnXmO0aF68ns3iRN8HVovLu+awWVzao2KxedNUZovDTQeZLXY9usnswOXRemk5i8fOWXfZ
        PT58jPN4d+4cu8fRlWuZPPbPXcPucb/7OJPH501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlnFjSxFTQKVEy99pq5gbGPt4uRk0NCwESi
        59cKti5GLg4hgaWMEuvnrmXsYuQASshIHF9fBlEjLPHnWhdUzWtGiemXVrKA1AgLREl8PMYJ
        UiMioC4xs6WfBaSGWaCbSeLeq72MEA29jBJLTkxnB6liE7CSmNi+ihHE5hWwk1j8tpkJxGYR
        UJX4tvEDC4gtKhAhcXjHLKgaQYmTM5+AxTmBev/sP8UKYjMDbfsz7xIzhC0ucevJfCYIW16i
        eets5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbrtmM/
        N+9gvLQx+BCjAAejEg/vjaKFcUKsiWXFlbmHGCU4mJVEeDc8nBcnxJuSWFmVWpQfX1Sak1p8
        iNEU6LmJzFKiyfnARJJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNT
        qoGRu+BVlJ+tQ/LDI+8rHiyw1og5U3blvpRH++lI7YD7DeFm/Rs2+k2rWnvS/zxHD3Or/GNu
        62MVJSvmpR7ZvLml1fX0r5yG6fMmec2e6y5zRSeXkY/9o7XhSb2VLCxfnVjn9S048Hjr75yT
        G/w3BxzWYOdaEP5vXt4T/ov3DhebH275kxLPI/JeiaU4I9FQi7moOBEAYiueT+wCAAA=
X-CMS-MailID: 20200423145536eucas1p1d17d340c8ac30b9e186bfaeaf593f1b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146
References: <CGME20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146@eucas1p2.samsung.com>
        <20200423142627.1820-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I believe that the patch summary line should be:

"[PATCH v2] console: newport_con: ..."

On 4/23/20 4:26 PM, Dejin Zheng wrote:
> A call of the function ¡°do_take_over_console¡± can fail here.
> The corresponding system resources were not released then.
> Thus add a call of the function ¡°iounmap¡± together with the check
> of a failure predicate.
> 
> Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")

I cannot see how this patch fixes commit e84de0c6190503
(AFAICS npregs has also been leaked on error before)?

> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v1 -> v2:
> 	- modify the commit comments by Markus'suggestion.
> 
>  drivers/video/console/newport_con.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> index 00dddf6e08b0..6bfc8e3ffd4a 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -720,6 +720,9 @@ static int newport_probe(struct gio_device *dev,
>  	console_lock();
>  	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>  	console_unlock();
> +
> +	if (err)
> +		iounmap((void *)npregs);

Looks OK but while you are at it, could you please also add missing
release_mem_region() on error and on device removal:

	newport_addr = dev->resource.start + 0xF0000;
	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
		return -ENODEV;

	npregs = (struct newport_regs *)/* ioremap cannot fail */
		ioremap(newport_addr, sizeof(struct newport_regs));
	console_lock();
	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
	console_unlock();
	return err;
}

static void newport_remove(struct gio_device *dev)
{
	give_up_console(&newport_con);
	iounmap((void *)npregs);
}

?

>  	return err;
>  }
>  

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
