Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF33C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E720692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="M1ZyPm84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDGAkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:40:41 -0400
Received: from sonic310-49.consmr.mail.gq1.yahoo.com ([98.137.69.175]:35341
        "EHLO sonic310-49.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDGAkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1586220039; bh=WqkBupthajN/wVNjyMab6WjNkJYjZbWKiQLkiDzGuL8=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=M1ZyPm84VdFE7nGdaCFwWB9dJFOU2AswpxkEQomEJzw9T0vV4NJG9RNfVmohcSg8mL2bEJEquJ6QW5EgoDGrp9iZ03c/41vIOhn4a2yr4ECZ5b3thfguhpBSoAgaRGyP/3OcAfwV68h5MKIs5s1fVsyEaZtue93megk8RR3qJOeIx9nagkd+ieOQt+ujWesq7Lyjr5Lhnx60jXnqQC7gWlOLqKpJMJN+Lf1pidgM/Eupa/RnUjTs3CRltdACwJPpUvLgoWVk3+RNL3reAYJDhtOKgw6/8MG+WEs6K8OmcOQh2WoVMVRftK1HBov8RLWQi2slsPgLLXfVFPQiBICMNw==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:40:39 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 56102bb25bec285dc24cdcfca4dac9a3;
          Tue, 07 Apr 2020 00:38:38 +0000 (UTC)
Date:   Mon, 06 Apr 2020 20:38:34 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: Bad rss-counter state from drm/ttm, drm/vmwgfx: Support huge TTM
 pagefaults
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Thomas =?iso-8859-1?q?Hellstr=F6m?= "(VMware)" 
        <thomas_os@shipmail.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?b?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-graphics-maintainer@vmware.com,
        Michal Hocko <mhocko@suse.com>, pv-drivers@vmware.com,
        Ralph Campbell <rcampbell@nvidia.com>,
        Roland Scheidegger <sroland@vmware.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <1586138158.v5u7myprlp.none.ref@localhost>
        <1586138158.v5u7myprlp.none@localhost>
        <0b12b28c-5f42-b56b-ea79-6e3d1052b332@shipmail.org>
In-Reply-To: <0b12b28c-5f42-b56b-ea79-6e3d1052b332@shipmail.org>
MIME-Version: 1.0
Message-Id: <1586219716.1a3fyi6lh5.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Thomas Hellstr=C3=B6m (VMware)'s message of April 6, 2020 5:0=
4 pm:
> Hi,
>=20
> On 4/6/20 9:51 PM, Alex Xu (Hello71) wrote:
>> Using 314b658 with amdgpu, starting sway and firefox causes "BUG: Bad
>> rss-counter state" and "BUG: non-zero pgtables_bytes on freeing mm" to
>> start filling dmesg, and then closing programs causes more BUGs and
>> hangs, and then everything grinds to a halt (can't start more programs,
>> can't even reboot through systemd).
>>
>> Using master and reverting that branch up to that point fixes the
>> problem.
>>
>> I'm using a Ryzen 1600 and AMD Radeon RX 480 on an ASRock B450 Pro4
>> board with IOMMU enabled.
>=20
> If you could try the attached patch, that'd be great!
>=20
> Thanks,
>=20
> Thomas
>=20

Yeah, that works too. Kernel config sent off-list.

Regards,
Alex.
