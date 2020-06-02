Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F018206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgFBKPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:15:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgFBKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:15:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052A39CD042984;
        Tue, 2 Jun 2020 06:14:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31cw8u3hws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 06:14:52 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 052A3Ctv043263;
        Tue, 2 Jun 2020 06:14:51 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31cw8u3hvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 06:14:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052ABG0D013655;
        Tue, 2 Jun 2020 10:14:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 31bf47abp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 10:14:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052AEjkI60621282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 10:14:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EACCA405B;
        Tue,  2 Jun 2020 10:14:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C2DA4060;
        Tue,  2 Jun 2020 10:14:41 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.74.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Jun 2020 10:14:40 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 02 Jun 2020 15:44:39 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH v9 0/5] powerpc/papr_scm: Add support for reporting nvdimm health
Date:   Tue,  2 Jun 2020 15:44:33 +0530
Message-Id: <20200602101438.73929-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_11:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 cotscore=-2147483648 priorityscore=1501
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v9 [1]:
* Added acks from Aneesh and Steven Steven Rostedt.

Changes since v8 [2]:

* Updated proposed changes to remove usage of term 'SCM' due to
  ambiguity with 'PMEM' and 'NVDIMM'. [ Dan Williams ]
* Replaced the usage of term 'SCM' with 'PMEM' in most contexts.
  [ Aneesh ]
* Renamed NVDIMM health defines from PAPR_SCM_DIMM_* to PAPR_PMEM_* .
* Updates to various newly introduced identifiers in 'papr_scm.c'
  removing the 'SCM' prefix from their names.
* Renamed NVDIMM_FAMILY_PAPR_SCM to NVDIMM_FAMILY_PAPR
* Renamed PAPR_SCM_PDSM_HEALTH PAPR_PDSM_HEALTH
* Renamed uapi header 'papr_scm_pdsm.h' to 'papr_pdsm.h'.
* Renamed sysfs ABI document from sysfs-bus-papr-scm to
  sysfs-bus-papr-pmem.
* No behavioural changes from v8 [1].

[1] https://lore.kernel.org/linux-nvdimm/20200529214719.223344-1-vaibhav@linux.ibm.com
[2] https://lore.kernel.org/linux-nvdimm/20200527041244.37821-1-vaibhav@linux.ibm.com/
---

The PAPR standard[3][5] provides mechanisms to query the health and
performance stats of an NVDIMM via various hcalls as described in
Ref[4].  Until now these stats were never available nor exposed to the
user-space tools like 'ndctl'. This is partly due to PAPR platform not
having support for ACPI and NFIT. Hence 'ndctl' is unable to query and
report the dimm health status and a user had no way to determine the
current health status of a NDVIMM.

To overcome this limitation, this patch-set updates papr_scm kernel
module to query and fetch NVDIMM health stats using hcalls described
in Ref[4].  This health and performance stats are then exposed to
userspace via sysfs and PAPR-NVDIMM-Specific-Methods(PDSM) issued by
libndctl.

These changes coupled with proposed ndtcl changes located at Ref[6]
should provide a way for the user to retrieve NVDIMM health status
using ndtcl.

Below is a sample output using proposed kernel + ndctl for PAPR NVDIMM
in a emulation environment:

 # ndctl list -DH
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"fatal",
      "shutdown_state":"dirty"
    }
  }
]

Dimm health report output on a pseries guest lpar with vPMEM or HMS
based NVDIMMs that are in perfectly healthy conditions:

 # ndctl list -d nmem0 -H
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"ok",
      "shutdown_state":"clean"
    }
  }
]

PAPR NVDIMM-Specific-Methods(PDSM)
==================================

PDSM requests are issued by vendor specific code in libndctl to
execute certain operations or fetch information from NVDIMMS. PDSMs
requests can be sent to papr_scm module via libndctl(userspace) and
libnvdimm (kernel) using the ND_CMD_CALL ioctl command which can be
handled in the dimm control function papr_scm_ndctl(). Current
patchset proposes a single PDSM to retrieve NVDIMM health, defined in
the newly introduced uapi header named 'papr_pdsm.h'. Support for
more PDSMs will be added in future.

Structure of the patch-set
==========================

The patch-set starts with a doc patch documenting details of hcall
H_SCM_HEALTH. Second patch exports kernel symbol seq_buf_printf()
thats used in subsequent patches to generate sysfs attribute content.

Third patch implements support for fetching NVDIMM health information
from PHYP and partially exposing it to user-space via a NVDIMM sysfs
flag.

Fourth patches deal with implementing support for servicing PDSM
commands in papr_scm module.

Finally the last patch implements support for servicing PDSM
'PAPR_PDSM_HEALTH' that returns the NVDIMM health information to
libndctl.

References:
[3] "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[4] commit 58b278f568f0
     ("powerpc: Provide initial documentation for PAPR hcalls")
[5] "Linux on Power Architecture Platform Reference"
     https://members.openpowerfoundation.org/document/dl/469
[6] https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v9

---

Vaibhav Jain (5):
  powerpc: Document details on H_SCM_HEALTH hcall
  seq_buf: Export seq_buf_printf
  powerpc/papr_scm: Fetch nvdimm health information from PHYP
  ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
  powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 ++
 Documentation/powerpc/papr_hcalls.rst         |  46 ++-
 arch/powerpc/include/uapi/asm/papr_pdsm.h     | 175 +++++++++
 arch/powerpc/platforms/pseries/papr_scm.c     | 363 +++++++++++++++++-
 include/uapi/linux/ndctl.h                    |   1 +
 lib/seq_buf.c                                 |   1 +
 6 files changed, 600 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-papr-pmem
 create mode 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h

-- 
2.26.2

