Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644E7C433EB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4695A22DCC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NxzfDbGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHFFWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:22:37 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:33151 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgHFFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596691352; x=1628227352;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=OQW0H78UJ23IVbOzQDkoYdhR+Awqzy61sILGifQaLKw=;
  b=NxzfDbGnlcmA8javYRkqnd+5G79yippvPH3QhN8Fn90dPi0RWRKzwFJD
   IynZ1VfnSC1dwcAxNGq41jg9O4QEJC65p8wvE7oMSWNPjKP3xkIAll6Kq
   o/EFGBjpPt90b6vz+a1nvq5lulzm9XZRYf9U7ohsuU01GqTO2jsfuYJt7
   o=;
IronPort-SDR: gkopOuEX2Cn7v/TiDjMGHNpNkuM1Cval3V3npvPD/mucYZgzO43+OstWK8UJA8JPvSQuaiAa88
 BEQUNkVF8Ngw==
X-IronPort-AV: E=Sophos;i="5.75,440,1589241600"; 
   d="scan'208";a="65965149"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Aug 2020 05:22:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 1CD95A229F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 05:22:27 +0000 (UTC)
Received: from EX13D16EUB003.ant.amazon.com (10.43.166.99) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 6 Aug 2020 05:22:27 +0000
Received: from 38f9d34ed3b1.ant.amazon.com (10.43.161.71) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 6 Aug 2020 05:22:24 +0000
Subject: Re: [PATCH v6 15/18] nitro_enclaves: Add Makefile for the Nitro
 Enclaves driver
To:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20200805091017.86203-16-andraprs@amazon.com>
 <202008052204.eXZb6di1%lkp@intel.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Message-ID: <1a829062-5dca-82f2-0497-f9cbe6468f37@amazon.com>
Date:   Thu, 6 Aug 2020 08:22:15 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202008052204.eXZb6di1%lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D37UWC003.ant.amazon.com (10.43.162.183) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/2020 17:23, kernel test robot wrote:
>
> Hi Andra,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master v5.8 next-20200805]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Andra-Paraschiv/Add-supp=
ort-for-Nitro-Enclaves/20200805-171942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t bcf876870b95592b52519ed4aafcf9d95999bc9c
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cro=
ss ARCH=3Darm64

Removed, for now, the dependency on ARM64 arch. x86 is currently =

supported, with Arm to come afterwards.

Thanks,
Andra

>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     drivers/virt/nitro_enclaves/ne_misc_dev.c: In function 'ne_setup_cpu_=
pool':
>>> drivers/virt/nitro_enclaves/ne_misc_dev.c:245:46: error: 'smp_num_sibli=
ngs' undeclared (first use in this function); did you mean 'cpu_sibling'?
>       245 |  ne_cpu_pool.avail_cores_size =3D nr_cpu_ids / smp_num_siblin=
gs;
>           |                                              ^~~~~~~~~~~~~~~~
>           |                                              cpu_sibling
>     drivers/virt/nitro_enclaves/ne_misc_dev.c:245:46: note: each undeclar=
ed identifier is reported only once for each function it appears in
>     drivers/virt/nitro_enclaves/ne_misc_dev.c: In function 'ne_enclave_io=
ctl':
>     drivers/virt/nitro_enclaves/ne_misc_dev.c:928:54: error: 'smp_num_sib=
lings' undeclared (first use in this function)
>       928 |   if (vcpu_id >=3D (ne_enclave->avail_cpu_cores_size * smp_nu=
m_siblings)) {
>           |                                                      ^~~~~~~~=
~~~~~~~~
>
> vim +245 drivers/virt/nitro_enclaves/ne_misc_dev.c
>
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  130
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  131  /**
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  132   * ne_setup_cpu_pool() -=
 Set the NE CPU pool after handling sanity checks such
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  133   *                      =
as not sharing CPU cores with the primary / parent VM
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  134   *                      =
or not using CPU 0, which should remain available for
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  135   *                      =
the primary / parent VM. Offline the CPUs from the
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  136   *                      =
pool after the checks passed.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  137   * @ne_cpu_list:       T=
he CPU list used for setting NE CPU pool.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  138   *
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  139   * Context: Process cont=
ext.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  140   * Return:
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  141   * * 0 on success.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  142   * * Negative return val=
ue on failure.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  143   */
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  144  static int ne_setup_cpu_=
pool(const char *ne_cpu_list)
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  145  {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  146         int core_id =3D -=
1;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  147         unsigned int cpu =
=3D 0;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  148         cpumask_var_t cpu=
_pool =3D NULL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  149         unsigned int cpu_=
sibling =3D 0;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  150         unsigned int i =
=3D 0;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  151         int numa_node =3D=
 -1;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  152         int rc =3D -EINVA=
L;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  153
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  154         if (!ne_cpu_list)
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  155                 return 0;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  156
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  157         if (!zalloc_cpuma=
sk_var(&cpu_pool, GFP_KERNEL))
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  158                 return -E=
NOMEM;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  159
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  160         mutex_lock(&ne_cp=
u_pool.mutex);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  161
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  162         rc =3D cpulist_pa=
rse(ne_cpu_list, cpu_pool);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  163         if (rc < 0) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  164                 pr_err("%=
s: Error in cpulist parse [rc=3D%d]\n", ne_misc_dev.name, rc);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  165
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  166                 goto free=
_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  167         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  168
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  169         cpu =3D cpumask_a=
ny(cpu_pool);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  170         if (cpu >=3D nr_c=
pu_ids) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  171                 pr_err("%=
s: No CPUs available in CPU pool\n", ne_misc_dev.name);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  172
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  173                 rc =3D -E=
INVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  174
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  175                 goto free=
_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  176         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  177
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  178         /*
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  179          * Check if the C=
PUs from the NE CPU pool are from the same NUMA node.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  180          */
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  181         for_each_cpu(cpu,=
 cpu_pool) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  182                 if (numa_=
node < 0) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  183                         n=
uma_node =3D cpu_to_node(cpu);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  184                         i=
f (numa_node < 0) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  185                          =
       pr_err("%s: Invalid NUMA node %d\n",
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  186                          =
              ne_misc_dev.name, numa_node);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  187
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  188                          =
       rc =3D -EINVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  189
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  190                          =
       goto free_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  191                         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  192                 } else {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  193                         i=
f (numa_node !=3D cpu_to_node(cpu)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  194                          =
       pr_err("%s: CPUs with different NUMA nodes\n",
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  195                          =
              ne_misc_dev.name);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  196
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  197                          =
       rc =3D -EINVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  198
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  199                          =
       goto free_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  200                         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  201                 }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  202         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  203
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  204         /*
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  205          * Check if CPU 0=
 and its siblings are included in the provided CPU pool
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  206          * They should re=
main available for the primary / parent VM.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  207          */
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  208         if (cpumask_test_=
cpu(0, cpu_pool)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  209                 pr_err("%=
s: CPU 0 has to remain available\n", ne_misc_dev.name);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  210
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  211                 rc =3D -E=
INVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  212
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  213                 goto free=
_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  214         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  215
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  216         for_each_cpu(cpu_=
sibling, topology_sibling_cpumask(0)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  217                 if (cpuma=
sk_test_cpu(cpu_sibling, cpu_pool)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  218                         p=
r_err("%s: CPU sibling %d for CPU 0 is in CPU pool\n",
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  219                          =
      ne_misc_dev.name, cpu_sibling);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  220
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  221                         r=
c =3D -EINVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  222
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  223                         g=
oto free_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  224                 }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  225         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  226
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  227         /*
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  228          * Check if CPU s=
iblings are included in the provided CPU pool. The
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  229          * expectation is=
 that CPU cores are made available in the CPU pool for
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  230          * enclaves.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  231          */
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  232         for_each_cpu(cpu,=
 cpu_pool) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  233                 for_each_=
cpu(cpu_sibling, topology_sibling_cpumask(cpu)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  234                         i=
f (!cpumask_test_cpu(cpu_sibling, cpu_pool)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  235                          =
       pr_err("%s: CPU %d is not in CPU pool\n",
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  236                          =
              ne_misc_dev.name, cpu_sibling);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  237
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  238                          =
       rc =3D -EINVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  239
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  240                          =
       goto free_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  241                         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  242                 }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  243         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  244
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05 @245         ne_cpu_pool.avail=
_cores_size =3D nr_cpu_ids / smp_num_siblings;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  246
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  247         ne_cpu_pool.avail=
_cores =3D kcalloc(ne_cpu_pool.avail_cores_size,
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  248                          =
                 sizeof(*ne_cpu_pool.avail_cores),
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  249                          =
                 GFP_KERNEL);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  250         if (!ne_cpu_pool.=
avail_cores) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  251                 rc =3D -E=
NOMEM;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  252
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  253                 goto free=
_pool_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  254         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  255
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  256         for (i =3D 0; i <=
 ne_cpu_pool.avail_cores_size; i++)
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  257                 if (!zall=
oc_cpumask_var(&ne_cpu_pool.avail_cores[i], GFP_KERNEL)) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  258                         r=
c =3D -ENOMEM;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  259
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  260                         g=
oto free_cores_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  261                 }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  262
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  263         /* Split the NE C=
PU pool in CPU cores. */
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  264         for_each_cpu(cpu,=
 cpu_pool) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  265                 core_id =
=3D topology_core_id(cpu);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  266                 if (core_=
id < 0 || core_id >=3D ne_cpu_pool.avail_cores_size) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  267                         p=
r_err("%s: Invalid core id  %d\n",
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  268                          =
      ne_misc_dev.name, core_id);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  269
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  270                         r=
c =3D -EINVAL;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  271
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  272                         g=
oto clear_cpumask;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  273                 }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  274
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  275                 cpumask_s=
et_cpu(cpu, ne_cpu_pool.avail_cores[core_id]);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  276         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  277
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  278         /*
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  279          * CPUs that are =
given to enclave(s) should not be considered online
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  280          * by Linux anymo=
re, as the hypervisor will degrade them to floating.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  281          * The physical C=
PUs (full cores) are carved out of the primary / parent
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  282          * VM and given t=
o the enclave VM. The same number of vCPUs would run
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  283          * on less pCPUs =
for the primary / parent VM.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  284          *
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  285          * We offline the=
m here, to not degrade performance and expose correct
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  286          * topology to Li=
nux and user space.
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  287          */
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  288         for_each_cpu(cpu,=
 cpu_pool) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  289                 rc =3D re=
move_cpu(cpu);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  290                 if (rc !=
=3D 0) {
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  291                         p=
r_err("%s: CPU %d is not offlined [rc=3D%d]\n",
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  292                          =
      ne_misc_dev.name, cpu, rc);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  293
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  294                         g=
oto online_cpus;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  295                 }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  296         }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  297
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  298         free_cpumask_var(=
cpu_pool);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  299
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  300         ne_cpu_pool.numa_=
node =3D numa_node;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  301
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  302         mutex_unlock(&ne_=
cpu_pool.mutex);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  303
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  304         return 0;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  305
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  306  online_cpus:
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  307         for_each_cpu(cpu,=
 cpu_pool)
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  308                 add_cpu(c=
pu);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  309  clear_cpumask:
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  310         for (i =3D 0; i <=
 ne_cpu_pool.avail_cores_size; i++)
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  311                 cpumask_c=
lear(ne_cpu_pool.avail_cores[i]);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  312  free_cores_cpumask:
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  313         for (i =3D 0; i <=
 ne_cpu_pool.avail_cores_size; i++)
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  314                 free_cpum=
ask_var(ne_cpu_pool.avail_cores[i]);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  315         kfree(ne_cpu_pool=
.avail_cores);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  316         ne_cpu_pool.avail=
_cores_size =3D 0;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  317  free_pool_cpumask:
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  318         free_cpumask_var(=
cpu_pool);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  319         mutex_unlock(&ne_=
cpu_pool.mutex);
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  320
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  321         return rc;
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  322  }
> 7d5c9a7dfa51e60 Andra Paraschiv 2020-08-05  323
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org




Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar=
 Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in R=
omania. Registration number J22/2621/2005.

