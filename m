Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE7EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD4C20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgEFRu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:50:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:36635 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgEFRu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:50:56 -0400
IronPort-SDR: 9nHmKby63c6/aIsHoFrwt5j2TDcddnFBd+6XRj0l/oLpMh6XZ72kAoyaGLCqazEYWa8ozuZtqn
 7l+KFG4b59YA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 10:50:51 -0700
IronPort-SDR: xm8tvqQxOE1rPKi9rbOCo7TO3uBzKdp1kfpW8KZL0EdRthEnS3SB3m0Ijjh17ghi7cG2E/af2F
 YVm1NUd2QXMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="461518608"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2020 10:50:51 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 10:50:50 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.56]) with mapi id 14.03.0439.000;
 Wed, 6 May 2020 10:50:49 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>, "hch@lst.de" <hch@lst.de>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
Thread-Topic: [PATCH v4 0/3] Replace private domain with per-group default
 domain
Thread-Index: AQHWI0qLt8RTAcgRzUWht5gocxEdBqiaxYyAgAEGfQA=
Date:   Wed, 6 May 2020 17:50:48 +0000
Message-ID: <d0fa0782473f5c7ef63dcded596ab6694b74b149.camel@intel.com>
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
         <CAD8Lp47E2CDmHTEGSpqYfxxKB4a+JY6VzZdL9e65P7YxqfL9Ag@mail.gmail.com>
In-Reply-To: <CAD8Lp47E2CDmHTEGSpqYfxxKB4a+JY6VzZdL9e65P7YxqfL9Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.179.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <07B3CD54AE2C8B4387A28686CBB77ED0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTA2IGF0IDEwOjA5ICswODAwLCBEYW5pZWwgRHJha2Ugd3JvdGU6DQo+
IE9uIFdlZCwgTWF5IDYsIDIwMjAgYXQgMTA6MDMgQU0gTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4gd3JvdGU6DQo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNC8xNC82
MTYNCj4gPiBbVGhpcyBoYXMgYmVlbiBhcHBsaWVkIGluIGlvbW11L25leHQuXQ0KPiA+IA0KPiA+
IEhlbmNlLCB0aGVyZSBpcyBubyBuZWVkIHRvIGtlZXAgdGhlIHByaXZhdGUgZG9tYWluIGltcGxl
bWVudGF0aW9uDQo+ID4gaW4gdGhlIEludGVsIElPTU1VIGRyaXZlci4gVGhpcyBwYXRjaCBzZXJp
ZXMgYWltcyB0byByZW1vdmUgaXQuDQo+IA0KPiBJIGFwcGxpZWQgdGhlc2UgcGF0Y2hlcyBvbiB0
b3Agb2YgSm9lcmcncyBicmFuY2ggYW5kIGNvbmZpcm1lZCB0aGF0DQo+IHRoZXkgZml4IHRoZSBp
c3N1ZSBkaXNjdXNzZWQgaW4gdGhlIHRocmVhZDoNCj4gDQo+IFtQQVRDSCB2Ml0gaW9tbXUvdnQt
ZDogY29uc2lkZXIgcmVhbCBQQ0kgZGV2aWNlIHdoZW4gY2hlY2tpbmcgaWYNCj4gbWFwcGluZyBp
cyBuZWVkZWQNCj4gKHRoZSBwYXRjaCB0aGVyZSBpcyBubyBsb25nZXIgbmVlZGVkKQ0KPiANCj4g
VGVzdGVkLWJ5OiBEYW5pZWwgRHJha2UgPGRyYWtlQGVuZGxlc3NtLmNvbT4NCj4gDQo+IFRoYW5r
cyENCg0KTG9va3MgbGlrZSB0aGUga2V5IHRvIHRoZSByZWFsIERNQSBkZXYgZml4IHdhcyByZW1v
dmluZw0KaWRlbnRpdHlfbWFwcGluZygpIHBhdGhzIHRoYXQgbGVkIHRvIGRldi0+YXJjaGRhdGEu
aW9tbXUgPT0gTlVMTCAtPiBETUENCmRvbWFpbg0KDQpXb3JrcyBncmVhdCBmb3IgbWUgYXMgd2Vs
bA0KDQpSZXZpZXdlZC1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29t
Pg0K
