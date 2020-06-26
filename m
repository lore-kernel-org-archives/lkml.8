Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCECFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7E6206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOn+hnxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgFZULf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:11:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgFZULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593202293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fWCZus3TfTyS/MOm72j+kbzDxTNx5spDUupLtAB1S0c=;
        b=NOn+hnxakK9id/8/LDXL/uYXwVTMNy4iIx8+bQHUEMKpiV5SyhpFVZ7k39pbSbrmecly8G
        xako9lmN0TFMAgpc0H9wiO/GwyO+TjXn7suWU4Bu8/KCxkX8tKdcge51tNs+eVbbG4jxm2
        4VNQJYbfVL7/VvWVHggXSgtGRp0JANk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-_OzQuzV1OQC6RyuXEBnc4A-1; Fri, 26 Jun 2020 16:11:29 -0400
X-MC-Unique: _OzQuzV1OQC6RyuXEBnc4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27261107ACCA;
        Fri, 26 Jun 2020 20:11:28 +0000 (UTC)
Received: from [10.10.115.20] (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B3CC5C541;
        Fri, 26 Jun 2020 20:11:26 +0000 (UTC)
Subject: Re: [Patch v1] i40e: limit the msix vectors based on housekeeping
 CPUs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, sassmann@redhat.com,
        jeffrey.t.kirsher@intel.com, jacob.e.keller@intel.com,
        jlelli@redhat.com
References: <20200615202125.27831-1-nitesh@redhat.com>
 <20200615202125.27831-2-nitesh@redhat.com>
 <20200616080309.GA21210@infradead.org>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <52220ae0-0ed5-f638-ebe2-725e0333ea6a@redhat.com>
Date:   Fri, 26 Jun 2020 16:11:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200616080309.GA21210@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EyqhfkQBk3ilLtw8YqQqgoSFPgTLemcZG"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EyqhfkQBk3ilLtw8YqQqgoSFPgTLemcZG
Content-Type: multipart/mixed; boundary="8bqknKfVNWtEz0vBxYHqoJlUuIXzzL85c"

--8bqknKfVNWtEz0vBxYHqoJlUuIXzzL85c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/16/20 4:03 AM, Christoph Hellwig wrote:
> On Mon, Jun 15, 2020 at 04:21:25PM -0400, Nitesh Narayan Lal wrote:
>> +=09hk_flags =3D HK_FLAG_DOMAIN | HK_FLAG_WQ;
>> +=09mask =3D housekeeping_cpumask(hk_flags);
>> +=09cpus =3D cpumask_weight(mask);
> Code like this has no business inside a driver.  Please provide a
> proper core API for it instead.  Also please wire up
> pci_alloc_irq_vectors* to use this API as well.
>

Hi Christoph,

I have been looking into using nr_houskeeping_* API that I will be defining
within pci_alloc_irq_vectors* to limit the nr of vectors.
However, I am wondering about a few things:

- Some of the drivers such as i40e until now, use the num_online CPUs to
=C2=A0 restrict the number of vectors that they should create. Will it make=
 sense if
=C2=A0 I restrict the maximum vectors requested based on
=C2=A0 nr_online/housekeeping_cpus (Though I will have to make sure that th=
e
=C2=A0 min_vecs is always satisfied)?

=C2=A0 The other option would be to check for the total available vectors i=
n all
=C2=A0 online/housekeeping CPUs for limiting the maxvecs, this way will pro=
bably be
=C2=A0 more accurate?

- Another thing that I am wondering about is the right way to test this cha=
nge.

Please let me know if you have any suggestions?

--=20
Nitesh


--8bqknKfVNWtEz0vBxYHqoJlUuIXzzL85c--

--EyqhfkQBk3ilLtw8YqQqgoSFPgTLemcZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl72VmwACgkQo4ZA3AYy
ozlWiBAAzgRtRT98cOOJaNMpp9iMHrZKMHazcwyVwdyMTqdz7LpjZsFTONSJDtui
l1hi+sU3nh/ppNBBxEeTb73cMHM6WVOKgx1Z/McSuTlpiunph27fJX/JUXhS4pfI
kFzCZWAWLcyWeoSnHEHoAUBLY35sLxVYyOgdrubFIbstdosMgASInrrWRlFfuhcM
+Y11OrhzlXOwMF0H14GsBaOmHBeMMSJGU5G9vToApXkbNpMDLCrxGL2SvqT4KSWO
CsdwnjzcgkqmX2TQru++Nm9QtayHLSxp7YQch1TdB0o5pbN0Horx/z06fEhmCjwm
ljMAduocpSRxY+UggjqC1J2swKRMi2WPkqwVmtq3COHwbx0I0x0EzIQL/J543P2S
UAVC/N8/zOkqK9SpplOmFJ6aX6KbxtXehyf42b7q8lSXrfY/b5OVWu8WYkmkopCY
fYMPRj6qIafU/A/GNz1SQhbsmHYIdmKhW+xBQLXV22x5zxAyWY1+s8Un0DbPRZMx
6hItsxURZm1nn0C/QSrh+DEVGv2TFPP6QjlY6MUr+j75dqh6GGLCP1K7QsvVYuKX
vG9Zt5GLO2dOZV/nuwKFxGghbO8uRmKyVVAr2bOnqhTQnx8H2YIF9Knygdlqzs7A
g59HeLCMicE0H+KRy8hjWmrkvPMz9IDcVQrPppSUVglzXHuSUqU=
=3fS8
-----END PGP SIGNATURE-----

--EyqhfkQBk3ilLtw8YqQqgoSFPgTLemcZG--

